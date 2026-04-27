package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "agendamentos")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Agendamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nomeCliente;
    private String telefone;
    private String veiculo;
    private String servicoDesejado;

    private LocalDateTime dataHora;

    private String status; // "Pendente", "Chegou" ou "Cancelado"
}