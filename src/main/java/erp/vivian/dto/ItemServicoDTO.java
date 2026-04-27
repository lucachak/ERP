package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;

public record ItemServicoDTO(
        Long servicoPadraoId, // NOVO: ID do catálogo

        String descricao, // Deixa de ser obrigatório aqui, validamos no service

        @NotNull(message = "A quantidade é obrigatória.")
        @Positive(message = "A quantidade deve ser maior que zero.") Double quantidade,

        BigDecimal valorUnitario, // Deixa de ser obrigatório aqui

        @NotBlank(message = "O nome do técnico é obrigatório.") String tecnico
) {}