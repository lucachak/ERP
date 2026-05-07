package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Min;
import java.math.BigDecimal;

public record ServicoPadraoDTO(
        Long id,
        @NotBlank(message = "A descrição é obrigatória.") String descricao,
        @NotNull(message = "O valor de mão-de-obra é obrigatório.")
        @PositiveOrZero(message = "O valor não pode ser negativo.") BigDecimal valorMaoDeObra,
        @NotNull(message = "O valor de material é obrigatório.")
        @PositiveOrZero(message = "O valor não pode ser negativo.") BigDecimal valorMaterial,
        @Min(value = 0, message = "O tempo não pode ser negativo.") Integer tempoEstimadoMin,
        String observacoes
) {}