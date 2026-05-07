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

    /** Valor total sugerido (maoDeObra + material) — calculado automaticamente */
    @Column(nullable = false)
    private BigDecimal valorPadrao;

    /** Custo fixo de mão-de-obra (ex: R$ 300,00) */
    @Column(nullable = false, columnDefinition = "NUMERIC(38,2) DEFAULT 0")
    private BigDecimal valorMaoDeObra;

    /** Custo estimado de material/produto (ex: R$ 1.500,00 em óleo) */
    @Column(nullable = false, columnDefinition = "NUMERIC(38,2) DEFAULT 0")
    private BigDecimal valorMaterial;

    /** Tempo mínimo estimado de execução em minutos (ex: 60) */
    @Column(nullable = false, columnDefinition = "INTEGER DEFAULT 0")
    private Integer tempoEstimadoMin;

    /** Observações livres (ex: "Usa 5-8L de óleo 5W30") */
    @Column(columnDefinition = "TEXT")
    private String observacoes;
}