package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "veiculos")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Veiculo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tipo;
    private String modelo;
    private String placaChassi;
    private String cor;
    private String ano;
    private String prisma;

    @ManyToOne
    @JoinColumn(name = "cliente_id")
    private Cliente cliente;
}