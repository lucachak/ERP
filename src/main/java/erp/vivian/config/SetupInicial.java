package erp.vivian.config;

import erp.vivian.model.Usuario;
import erp.vivian.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@RequiredArgsConstructor
public class SetupInicial implements CommandLineRunner {

    private final UsuarioRepository repository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        if (repository.findByUsername("dalva").isEmpty()) {
            Usuario dalva = new Usuario();
            dalva.setUsername("dalva");
            dalva.setPassword(passwordEncoder.encode("dalva"));
            dalva.setRole("ROLE_ADMIN");

            repository.save(dalva);

            System.out.println("=========================================");
            System.out.println("NOVO UTILIZADOR CRIADO COM SUCESSO!");
            System.out.println("Login: dalva");
            System.out.println("Senha: dalva");
            System.out.println("=========================================");
        } else {
            System.out.println("=========================================");
            System.out.println("SETUP INICIAL: O usuário 'dalva' já existe no banco de dados.");
            System.out.println("=========================================");
        }
    }
}