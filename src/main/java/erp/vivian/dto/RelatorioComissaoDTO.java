package erp.vivian.dto;

import java.math.BigDecimal;

public record RelatorioComissaoDTO(
        String tecnico,
        Long quantidadeServicos,
        BigDecimal totalGerado
) {}