package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "itens_peca")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ItemPeca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String codigoPeca;
    private String descricao;
    private Double quantidade;
    private BigDecimal valorUnitario;
    private BigDecimal valorTotal;

    @ManyToOne
    @JoinColumn(name = "ordem_servico_id")
    private OrdemServico ordemServico;

    // NOVO RELACIONAMENTO: Liga este item à peça real no estoque
    @ManyToOne
    @JoinColumn(name = "peca_estoque_id")
    private Peca pecaEstoque;
}