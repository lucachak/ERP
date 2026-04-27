package erp.vivian.service;

import erp.vivian.dto.ItemPecaDTO;
import erp.vivian.dto.ItemServicoDTO;
import erp.vivian.dto.NovaOsDTO;
import erp.vivian.dto.OsExtraInfoDTO;
import erp.vivian.model.*;
import erp.vivian.repository.ClienteRepository;
import erp.vivian.repository.OrdemServicoRepository;
import erp.vivian.repository.PecaRepository;
import erp.vivian.repository.VeiculoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class OrdemServicoService {

    private final OrdemServicoRepository osRepository;
    private final ClienteRepository clienteRepository;
    private final VeiculoRepository veiculoRepository;
    private final PecaRepository pecaRepository;
    private final erp.vivian.repository.ServicoPadraoRepository servicoPadraoRepository;

    public List<OrdemServico> listarTodas() {
        return osRepository.findAll();
    }

    @Transactional
    public OrdemServico criarNovaOs(NovaOsDTO dto) { // Agora retorna a OrdemServico criada

        Cliente cliente;

        // 1. Verifica se é um Cliente Existente ou Novo
        if (dto.clienteId() != null) {
            cliente = clienteRepository.findById(dto.clienteId())
                    .orElseThrow(() -> new IllegalArgumentException("Cliente não encontrado"));
        } else {
            if (dto.clienteNome() == null || dto.clienteNome().trim().isEmpty()) {
                throw new IllegalArgumentException("O nome do cliente é obrigatório para novos cadastros.");
            }
            cliente = new Cliente();
            cliente.setNome(dto.clienteNome().toUpperCase());
            cliente.setCelular(dto.celular());
            cliente.setTelefone(dto.telefone());
            cliente.setEmail(dto.email());
            cliente.setCpfCnpj(dto.cpfCnpj());
            cliente.setRgIe(dto.rgIe());
            cliente.setEndereco(dto.endereco());
            cliente.setBairro(dto.bairro());
            cliente.setCidade(dto.cidade());
            cliente = clienteRepository.save(cliente);
        }

        // 2. Cria e guarda o Veículo vinculado ao Cliente
        Veiculo veiculo = new Veiculo();
        veiculo.setModelo(dto.veiculoModelo().toUpperCase());
        veiculo.setPlacaChassi(dto.placa() != null ? dto.placa().toUpperCase() : null);
        veiculo.setAno(dto.ano());
        veiculo.setPrisma(dto.prisma());
        veiculo.setCliente(cliente);
        veiculo = veiculoRepository.save(veiculo);

        // 3. Cria e guarda a O.S. vinculada a ambos
        OrdemServico os = new OrdemServico();
        os.setNumeroOs(UUID.randomUUID().toString().substring(0, 6).toUpperCase());
        os.setDataEmissao(LocalDateTime.now());
        os.setSituacao("Aberta");
        os.setProblemaReclamado(dto.problemaReclamado());
        os.setMetodoPagamento(dto.metodoPagamento());
        os.setCliente(cliente);
        os.setVeiculo(veiculo);

        // Inicializa totais a zero
        os.setTotalServicos(BigDecimal.ZERO);
        os.setTotalPecas(BigDecimal.ZERO);
        os.setFrete(BigDecimal.ZERO);
        os.setValorTotal(BigDecimal.ZERO);

        return osRepository.save(os);
    }

    public OrdemServico buscarPorId(Long id) {
        return osRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Ordem de Serviço não encontrada"));
    }

    @Transactional
    public OrdemServico adicionarServico(Long osId, ItemServicoDTO dto) {
        OrdemServico os = buscarPorId(osId);
        ItemServico item = new ItemServico();

        if (dto.servicoPadraoId() != null) {
            ServicoPadrao sp = servicoPadraoRepository.findById(dto.servicoPadraoId())
                    .orElseThrow(() -> new IllegalArgumentException("Serviço padrão não encontrado."));
            item.setDescricao(sp.getDescricao());
            item.setValorUnitario(dto.valorUnitario() != null ? dto.valorUnitario() : sp.getValorPadrao());
        } else {
            if (dto.descricao() == null || dto.descricao().isBlank()) {
                throw new IllegalArgumentException("A descrição é obrigatória para serviços avulsos.");
            }
            if (dto.valorUnitario() == null) {
                throw new IllegalArgumentException("O valor unitário é obrigatório para serviços avulsos.");
            }
            item.setDescricao(dto.descricao().toUpperCase());
            item.setValorUnitario(dto.valorUnitario());
        }

        item.setQuantidade(dto.quantidade());
        item.setUnidade("Hs");
        item.setValorTotal(item.getValorUnitario().multiply(BigDecimal.valueOf(dto.quantidade())));
        item.setTecnico(dto.tecnico().toUpperCase());
        item.setOrdemServico(os);

        os.getServicos().add(item);
        calcularTotais(os);

        return osRepository.save(os);
    }

    @Transactional
    public OrdemServico fecharOs(Long id) {
        OrdemServico os = buscarPorId(id);
        if ("Encerrada".equals(os.getSituacao())) {
            throw new IllegalStateException("Esta O.S. já encontra-se encerrada.");
        }
        os.setSituacao("Encerrada");
        os.setDataEntrega(LocalDateTime.now());
        os.setDataGarantia(java.time.LocalDate.now().plusDays(90));
        return osRepository.save(os);
    }

    @Transactional
    public OrdemServico adicionarPeca(Long osId, ItemPecaDTO dto) {
        OrdemServico os = buscarPorId(osId);
        ItemPeca item = new ItemPeca();

        if (dto.pecaEstoqueId() != null) {
            Peca peca = pecaRepository.findById(dto.pecaEstoqueId())
                    .orElseThrow(() -> new IllegalArgumentException("Peça não encontrada no estoque."));
            if (peca.getQuantidadeEstoque() < dto.quantidade()) {
                throw new IllegalStateException("Estoque insuficiente! Disponível: " + peca.getQuantidadeEstoque());
            }
            peca.setQuantidadeEstoque(peca.getQuantidadeEstoque() - dto.quantidade());
            pecaRepository.save(peca);

            item.setPecaEstoque(peca);
            item.setCodigoPeca(peca.getCodigo() != null ? peca.getCodigo() : "S/N");
            item.setDescricao(peca.getDescricao());
            item.setValorUnitario(dto.valorUnitario() != null ? dto.valorUnitario() : peca.getPrecoVenda());
        } else {
            if (dto.descricao() == null || dto.descricao().isBlank()) {
                throw new IllegalArgumentException("A descrição é obrigatória para peças avulsas.");
            }
            if (dto.valorUnitario() == null) {
                throw new IllegalArgumentException("O valor unitário é obrigatório para peças avulsas.");
            }
            item.setCodigoPeca(dto.codigoPeca() != null && !dto.codigoPeca().isBlank() ? dto.codigoPeca() : "S/N");
            item.setDescricao(dto.descricao().toUpperCase());
            item.setValorUnitario(dto.valorUnitario());
        }

        item.setQuantidade(dto.quantidade());
        item.setValorTotal(item.getValorUnitario().multiply(BigDecimal.valueOf(dto.quantidade())));
        item.setOrdemServico(os);

        os.getPecas().add(item);
        calcularTotais(os);
        return osRepository.save(os);
    }

    private void calcularTotais(OrdemServico os) {
        BigDecimal totalServicos = os.getServicos().stream()
                .map(item -> item.getValorTotal() != null ? item.getValorTotal() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        os.setTotalServicos(totalServicos);

        BigDecimal totalPecas = os.getPecas().stream()
                .map(item -> item.getValorTotal() != null ? item.getValorTotal() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        os.setTotalPecas(totalPecas);

        BigDecimal frete = os.getFrete() != null ? os.getFrete() : BigDecimal.ZERO;
        os.setValorTotal(totalServicos.add(totalPecas).add(frete));
    }

    @Transactional
    public OrdemServico atualizarExtras(Long id, OsExtraInfoDTO dto) {
        OrdemServico os = buscarPorId(id);
        if ("Encerrada".equals(os.getSituacao())) {
            throw new IllegalStateException("Não é possível alterar uma O.S. encerrada.");
        }
        os.setFrete(dto.frete() != null ? dto.frete() : BigDecimal.ZERO);
        os.setObservacoes(dto.observacoes());
        os.setCheckPressaoGas(dto.checkPressaoGas());
        os.setCheckFiltroCabine(dto.checkFiltroCabine());
        os.setCheckCompressor(dto.checkCompressor());
        os.setCheckHigienizacao(dto.checkHigienizacao());
        calcularTotais(os);
        return osRepository.save(os);
    }

    @Transactional
    public OrdemServico removerServico(Long osId, Long servicoId) {
        OrdemServico os = buscarPorId(osId);
        if ("Encerrada".equals(os.getSituacao())) {
            throw new IllegalStateException("Não é possível alterar uma O.S. encerrada.");
        }
        os.getServicos().removeIf(s -> s.getId().equals(servicoId));
        calcularTotais(os);
        return osRepository.save(os);
    }

    @Transactional
    public OrdemServico removerPeca(Long osId, Long pecaId) {
        OrdemServico os = buscarPorId(osId);
        if ("Encerrada".equals(os.getSituacao())) {
            throw new IllegalStateException("Não é possível alterar uma O.S. encerrada.");
        }
        ItemPeca itemParaRemover = os.getPecas().stream()
                .filter(p -> p.getId().equals(pecaId)).findFirst().orElse(null);

        if (itemParaRemover != null) {
            if (itemParaRemover.getPecaEstoque() != null) {
                Peca peca = itemParaRemover.getPecaEstoque();
                peca.setQuantidadeEstoque(peca.getQuantidadeEstoque() + itemParaRemover.getQuantidade());
                pecaRepository.save(peca);
            }
            os.getPecas().remove(itemParaRemover);
            calcularTotais(os);
        }
        return osRepository.save(os);
    }

    public Page<OrdemServico> pesquisar(String termo, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "dataEmissao"));
        if (termo == null || termo.isBlank()) {
            return osRepository.findAll(pageRequest);
        }
        return osRepository.pesquisar(termo, pageRequest);
    }

    @Transactional
    public OrdemServico atualizarSituacao(Long id, String novaSituacao) {
        OrdemServico os = buscarPorId(id);
        os.setSituacao(novaSituacao);
        if ("Encerrada".equals(novaSituacao)) {
            os.setDataEntrega(LocalDateTime.now());
            os.setDataGarantia(java.time.LocalDate.now().plusDays(90));
        } else {
            os.setDataEntrega(null);
            os.setDataGarantia(null);
        }
        return osRepository.save(os);
    }

    public List<OrdemServico> buscarNoKanban(String situacao, String termo) {
        return osRepository.buscarNoKanban(situacao, termo);
    }
}