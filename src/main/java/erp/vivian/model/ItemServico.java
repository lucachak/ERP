package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "itens_servico")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ItemServico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String codigoServico; // Ex: 00001
    private String descricao; // Ex: CARGA DE GÁS
    private Double quantidade; // Ex: 1.00
    private String unidade; // Ex: Hs
    private BigDecimal valorUnitario; // Ex: 200.00
    private BigDecimal valorTotal; // Ex: 200.00
    private String tecnico; // Ex: LUIZ DANIEL

    @ManyToOne
    @JoinColumn(name = "ordem_servico_id")
    private OrdemServico ordemServico;
}
