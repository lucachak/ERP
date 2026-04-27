package erp.vivian.service;

import erp.vivian.dto.TransacaoDTO;
import erp.vivian.model.TransacaoCaixa;
import erp.vivian.repository.TransacaoCaixaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CaixaService {

    private final TransacaoCaixaRepository repository;

    public void salvarTransacao(TransacaoDTO dto) {
        TransacaoCaixa transacao = new TransacaoCaixa();
        transacao.setDescricao(dto.descricao().toUpperCase());
        transacao.setTipo(dto.tipo().toUpperCase());
        transacao.setValor(dto.valor());
        transacao.setDataRegistro(LocalDateTime.now());

        // Mapear os novos campos
        transacao.setStatus(dto.status().toUpperCase());
        transacao.setDataVencimento(dto.dataVencimento());
        transacao.setCategoria(dto.categoria() != null && !dto.categoria().isBlank() ? dto.categoria().toUpperCase() : "GERAL");
        transacao.setFormaPagamento(dto.formaPagamento() != null && !dto.formaPagamento().isBlank() ? dto.formaPagamento().toUpperCase() : "NÃO INFORMADA");

        // Se a pessoa já cadastrar a conta como "PAGA", gravamos a data de hoje como data de pagamento
        if ("PAGO".equals(transacao.getStatus())) {
            transacao.setDataPagamento(LocalDate.now());
        }

        repository.save(transacao);
    }

    // NOVO MÉTODO: Usado para quando clicarmos num botão "Marcar como Pago" na tela
    public void baixarTransacao(Long id) {
        TransacaoCaixa transacao = repository.findById(id).orElseThrow(() -> new IllegalArgumentException("Transação não encontrada"));
        transacao.setStatus("PAGO");
        transacao.setDataPagamento(LocalDate.now());
        repository.save(transacao);
    }

    public void excluirTransacao(Long id) {
        repository.deleteById(id);
    }

    public List<TransacaoCaixa> buscarTransacoes(YearMonth mesAno) {
        LocalDateTime inicio = mesAno.atDay(1).atStartOfDay();
        LocalDateTime fim = mesAno.atEndOfMonth().atTime(LocalTime.MAX);
        return repository.findByDataRegistroBetweenOrderByDataRegistroDesc(inicio, fim);
    }
}