package erp.vivian.controller;

import erp.vivian.model.Usuario;
import erp.vivian.repository.UsuarioRepository;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class UsuarioController {

    private final UsuarioRepository repository;
    private final PasswordEncoder encoder;

    @PostMapping("/usuarios/rapido")
    public String criarUsuarioRapido(@RequestParam String username,
                                     @RequestParam String password,
                                     @RequestParam String role, // NOVO PARÂMETRO
                                     Model model, HttpServletResponse response) {

        if (repository.findByUsername(username).isPresent()) {
            model.addAttribute("mensagemErro", "Este nome de utilizador já existe.");
            return "fragmentos/toast :: erroToast";
        }

        Usuario u = new Usuario();
        u.setUsername(username.toLowerCase());
        u.setPassword(encoder.encode(password));
        u.setRole(role); // Agora guarda se é ADMIN ou ATENDENTE
        repository.save(u);

        model.addAttribute("mensagemSucesso", "Usuário " + username + " criado com sucesso!");
        response.setHeader("HX-Retarget", "#toast-container");
        response.setHeader("HX-Reswap", "innerHTML");
        return "fragmentos/toast :: sucessoToast";
    }

}