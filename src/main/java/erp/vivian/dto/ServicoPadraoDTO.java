package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import java.math.BigDecimal;

public record ServicoPadraoDTO(
        Long id,
        @NotBlank(message = "A descrição é obrigatória.") String descricao,
        @NotNull(message = "O valor padrão é obrigatório.")
        @PositiveOrZero(message = "O valor não pode ser negativo.") BigDecimal valorPadrao
) {}