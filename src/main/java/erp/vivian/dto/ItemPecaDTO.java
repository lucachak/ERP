package erp.vivian.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;

public record ItemPecaDTO(
        Long pecaEstoqueId, // ID da peça vinda do estoque (se selecionada)
        String codigoPeca,
        String descricao,

        @NotNull(message = "A quantidade é obrigatória.")
        @Positive(message = "A quantidade deve ser maior que zero.") Double quantidade,

        BigDecimal valorUnitario
) {}