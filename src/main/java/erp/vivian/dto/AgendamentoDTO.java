package erp.vivian.dto;

import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

public record AgendamentoDTO(
        String nomeCliente,
        String telefone,
        String veiculo,
        String servicoDesejado,

        // Esta anotação ensina o Spring a ler o calendário do HTML corretamente
        @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
        LocalDateTime dataHora
) {}