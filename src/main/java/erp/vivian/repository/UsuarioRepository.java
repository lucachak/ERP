package erp.vivian.repository;

import erp.vivian.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    // Método mágico do Spring que procura um utilizador pelo seu "username"
    Optional<Usuario> findByUsername(String username);
}