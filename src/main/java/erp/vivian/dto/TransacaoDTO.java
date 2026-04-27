package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;

public record TransacaoDTO(
        @NotBlank(message = "A descrição é obrigatória") String descricao,
        @NotBlank(message = "O tipo é obrigatório") String tipo,
        @NotNull(message = "O valor é obrigatório") BigDecimal valor,

        // Novos campos obrigatórios para o formulário
        @NotBlank(message = "O status é obrigatório") String status,
        @NotNull(message = "A data de vencimento é obrigatória") LocalDate dataVencimento,

        String categoria,
        String formaPagamento
) {}