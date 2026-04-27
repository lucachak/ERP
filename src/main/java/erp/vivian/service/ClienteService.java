package erp.vivian.service;

import erp.vivian.model.Cliente;
import erp.vivian.model.OrdemServico;
import erp.vivian.repository.ClienteRepository;
import erp.vivian.repository.OrdemServicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteService {

    private final ClienteRepository clienteRepository;
    private final OrdemServicoRepository osRepository;

    public Page<Cliente> pesquisar(String termo, int page, int size) {
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.ASC, "nome"));
        if (termo == null || termo.isBlank()) {
            return clienteRepository.findAll(pageRequest);
        }
        return clienteRepository.pesquisarCRM(termo, pageRequest);
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Cliente não encontrado."));
    }

    public List<OrdemServico> buscarHistoricoOs(Long clienteId) {
        return osRepository.findByClienteIdOrderByDataEmissaoDesc(clienteId);
    }

    // NOVO MÉTODO: Para salvar o cliente no banco de dados
    public Cliente salvar(Cliente cliente) {
        // Se quisermos formatar o nome para maiúsculas antes de salvar, podemos fazer aqui
        if (cliente.getNome() != null) {
            cliente.setNome(cliente.getNome().toUpperCase());
        }
        return clienteRepository.save(cliente);
    }

    public Cliente atualizar(Long id, Cliente dadosAtualizados) {
        Cliente clienteExistente = buscarPorId(id);

        if (dadosAtualizados.getNome() != null) {
            clienteExistente.setNome(dadosAtualizados.getNome().toUpperCase());
        }

        // Atualiza os restantes campos com os novos dados do formulário
        clienteExistente.setCpfCnpj(dadosAtualizados.getCpfCnpj());
        clienteExistente.setCelular(dadosAtualizados.getCelular());
        clienteExistente.setEmail(dadosAtualizados.getEmail());
        clienteExistente.setEndereco(dadosAtualizados.getEndereco());
        clienteExistente.setBairro(dadosAtualizados.getBairro());
        clienteExistente.setCidade(dadosAtualizados.getCidade());

        return clienteRepository.save(clienteExistente);
    }
}