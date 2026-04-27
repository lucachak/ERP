package erp.vivian.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "usuarios")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username; // Ex: "lucas.admin" ou "atendimento"

    @Column(nullable = false)
    private String password; // A senha ficará criptografada no banco

    private String role; // Ex: "ROLE_ADMIN" ou "ROLE_ATENDENTE"
}