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
    if (repository.findByUsername("lucas").isEmpty()) {
      Usuario lucas = new Usuario();
      lucas.setUsername("lucas");
      lucas.setPassword(passwordEncoder.encode("lucas"));
      lucas.setRole("ROLE_ADMIN");

      repository.save(lucas);

      System.out.println("=========================================");
      System.out.println("NOVO UTILIZADOR CRIADO COM SUCESSO!");
      System.out.println("Login: lucas");
      System.out.println("Senha: lucas");
      System.out.println("=========================================");
    } else {
      System.out.println("=========================================");
      System.out.println("SETUP INICIAL: O usuário 'lucas' já existe no banco de dados.");
      System.out.println("=========================================");
    }
  }
}

