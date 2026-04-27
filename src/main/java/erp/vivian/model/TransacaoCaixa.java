package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "transacoes_caixa")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TransacaoCaixa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String descricao;
    private String tipo; // ENTRADA ou SAIDA
    private BigDecimal valor;

    // Data exata em que o registo foi criado no sistema
    private LocalDateTime dataRegistro;

    // --- NOVOS CAMPOS: FINANCEIRO ROBUSTO ---
    private String status; // PENDENTE ou PAGO
    private LocalDate dataVencimento; // Data limite para pagar/receber
    private LocalDate dataPagamento; // Quando o dinheiro efetivamente saiu/entrou
    private String categoria; // Ex: Fornecedores, Salários, Impostos, Água/Luz
    private String formaPagamento; // Ex: PIX, Boleto, Dinheiro, Transferência
}