package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "servicos_padrao")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ServicoPadrao {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String descricao;

    @Column(nullable = false)
    private BigDecimal valorPadrao;
}