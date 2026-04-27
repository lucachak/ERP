package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "ordens_servico")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class OrdemServico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String numeroOs;

    private LocalDateTime dataEmissao;
    private LocalDateTime dataEntrega;
    private java.time.LocalDate dataGarantia;


    private String situacao;
    private String atendente;
    private String problemaReclamado;
    private String observacoes;
    private String metodoPagamento; // Novo campo

    private String checkPressaoGas;
    private String checkFiltroCabine;
    private String checkCompressor;
    private String checkHigienizacao;

    // Relacionamentos
    @ManyToOne
    @JoinColumn(name = "cliente_id")
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "veiculo_id")
    private Veiculo veiculo;

    @OneToMany(mappedBy = "ordemServico", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ItemServico> servicos = new ArrayList<>();

    // Novo Relacionamento com Peças
    @OneToMany(mappedBy = "ordemServico", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ItemPeca> pecas = new ArrayList<>();

    // Totais Financeiros
    private BigDecimal totalServicos;
    private BigDecimal totalPecas;
    private BigDecimal frete;
    private BigDecimal valorTotal;
}