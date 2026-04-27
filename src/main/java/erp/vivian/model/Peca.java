package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "pecas")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Peca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String codigo;

    @Column(nullable = false)
    private String descricao;

    private Double quantidadeEstoque;
    private BigDecimal precoCusto;
    private BigDecimal precoVenda;
}