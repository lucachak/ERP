package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "clientes")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;
    private String celular;
    private String telefone; // Novo campo
    private String email;    // Novo campo
    private String endereco;
    private String bairro;
    private String cidade;
    private String cpfCnpj;
    private String rgIe;
    @OneToMany(mappedBy = "cliente")
    private java.util.List<Veiculo> veiculos;
}