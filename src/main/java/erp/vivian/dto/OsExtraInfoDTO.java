package erp.vivian.dto;

import jakarta.validation.constraints.Min;
import java.math.BigDecimal;

public record OsExtraInfoDTO(
        @Min(value = 0, message = "O frete não pode ter um valor negativo.") BigDecimal frete,
        String observacoes,

        // Novos campos do Checklist
        String checkPressaoGas,
        String checkFiltroCabine,
        String checkCompressor,
        String checkHigienizacao
) {}