package erp.vivian.controller;

import erp.vivian.dto.UsuarioDTO;
import erp.vivian.service.UsuarioService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UsuarioController {

    private final UsuarioService service;

    // ================= ADMIN: GERENCIAR USUÁRIOS =================
    @GetMapping("/usuarios")
    public String index(Model model) {
        model.addAttribute("usuarios", service.listarTodos());
        return "usuarios/index";
    }

    @PostMapping("/usuarios/salvar")
    public String salvar(@Valid @ModelAttribute UsuarioDTO dto, RedirectAttributes attributes) {
        try {
            service.salvarUsuario(dto);
            attributes.addFlashAttribute("mensagemSucesso", "Usuário salvo com sucesso!");
        } catch (IllegalArgumentException e) {
            attributes.addFlashAttribute("mensagemErro", e.getMessage());
        }
        return "redirect:/usuarios";
    }

    @DeleteMapping("/usuarios/{id}/excluir")
    @ResponseBody
    public String excluir(@PathVariable Long id) {
        service.excluir(id);
        return ""; // HTMX target
    }

    // ================= QUALQUER USUÁRIO: MEU PERFIL =================
    @GetMapping("/perfil")
    public String perfil(Model model, Principal principal) {
        if (principal == null) return "redirect:/login";
        model.addAttribute("usuario", service.buscarPorUsername(principal.getName()));
        return "usuarios/perfil";
    }

    @PostMapping("/perfil/salvar")
    public String salvarPerfil(@RequestParam String novaSenha, Principal principal, RedirectAttributes attributes) {
        if (principal == null) return "redirect:/login";
        try {
            service.atualizarSenha(principal.getName(), novaSenha);
            attributes.addFlashAttribute("mensagemSucesso", "Senha atualizada com sucesso!");
        } catch (IllegalArgumentException e) {
            attributes.addFlashAttribute("mensagemErro", e.getMessage());
        }
        return "redirect:/perfil";
    }

    @PostMapping("/usuarios/rapido")
    public String criarUsuarioRapido(@RequestParam String username,
                                     @RequestParam String password,
                                     @RequestParam String role,
                                     Model model, HttpServletResponse response) {
        try {
            UsuarioDTO dto = new UsuarioDTO(null, username, password, role);
            service.salvarUsuario(dto);
            model.addAttribute("mensagemSucesso", "Usuário " + username + " criado com sucesso!");
            response.setHeader("HX-Retarget", "#toast-container");
            response.setHeader("HX-Reswap", "innerHTML");
            return "fragmentos/toast :: sucessoToast";
        } catch (IllegalArgumentException e) {
            model.addAttribute("mensagemErro", e.getMessage());
            return "fragmentos/toast :: erroToast";
        }
    }
}