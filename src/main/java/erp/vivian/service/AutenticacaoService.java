package erp.vivian.service;

import erp.vivian.model.Usuario;
import erp.vivian.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AutenticacaoService implements UserDetailsService {

    private final UsuarioRepository repository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. Vai ao banco procurar o utilizador
        Usuario usuario = repository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Utilizador não encontrado: " + username));

        // 2. Transforma o nosso 'Usuario' no 'UserDetails' que o Spring Security entende
        return User.builder()
                .username(usuario.getUsername())
                .password(usuario.getPassword())
                .roles(usuario.getRole().replace("ROLE_", "")) // O Spring exige o papel sem o prefixo "ROLE_"
                .build();
    }
}