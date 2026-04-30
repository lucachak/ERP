package erp.vivian.service;

import erp.vivian.dto.UsuarioDTO;
import erp.vivian.model.Usuario;
import erp.vivian.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UsuarioService {

    private final UsuarioRepository repository;
    private final PasswordEncoder encoder;

    public List<Usuario> listarTodos() {
        return repository.findAll();
    }

    public Usuario buscarPorId(Long id) {
        return repository.findById(id).orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));
    }

    public Usuario buscarPorUsername(String username) {
        return repository.findByUsername(username).orElseThrow(() -> new IllegalArgumentException("Usuário não encontrado."));
    }

    public void salvarUsuario(UsuarioDTO dto) {
        Usuario u;
        if (dto.id() != null) {
            u = buscarPorId(dto.id());
            // Atualizar
            
            // Só muda o username se for diferente e o novo não existir
            if (!u.getUsername().equalsIgnoreCase(dto.username())) {
                if (repository.findByUsername(dto.username().toLowerCase()).isPresent()) {
                    throw new IllegalArgumentException("Este nome de utilizador já existe.");
                }
                u.setUsername(dto.username().toLowerCase());
            }
            
            u.setRole(dto.role());
            if (dto.password() != null && !dto.password().isBlank()) {
                u.setPassword(encoder.encode(dto.password()));
            }
        } else {
            // Novo
            if (repository.findByUsername(dto.username().toLowerCase()).isPresent()) {
                throw new IllegalArgumentException("Este nome de utilizador já existe.");
            }
            u = new Usuario();
            u.setUsername(dto.username().toLowerCase());
            u.setRole(dto.role() == null ? "ROLE_ATENDENTE" : dto.role());
            if (dto.password() == null || dto.password().isBlank()) {
                throw new IllegalArgumentException("A senha é obrigatória para novos usuários.");
            }
            u.setPassword(encoder.encode(dto.password()));
        }
        repository.save(u);
    }

    public void atualizarSenha(String username, String novaSenha) {
        if (novaSenha == null || novaSenha.isBlank()) {
            throw new IllegalArgumentException("A senha não pode estar vazia.");
        }
        Usuario u = buscarPorUsername(username);
        u.setPassword(encoder.encode(novaSenha));
        repository.save(u);
    }

    public void excluir(Long id) {
        repository.deleteById(id);
    }
}
