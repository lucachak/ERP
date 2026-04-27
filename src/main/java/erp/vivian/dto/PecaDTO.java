package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import java.math.BigDecimal;

public record PecaDTO(
        String codigo,

        @NotBlank(message = "A descrição da peça é obrigatória.")
        String descricao,

        @NotNull(message = "A quantidade é obrigatória.")
        @PositiveOrZero(message = "O estoque não pode ser negativo.")
        Double quantidadeEstoque,

        BigDecimal precoCusto,

        @NotNull(message = "O preço de venda é obrigatório.")
        @PositiveOrZero(message = "O preço de venda não pode ser negativo.")
        BigDecimal precoVenda
) {}