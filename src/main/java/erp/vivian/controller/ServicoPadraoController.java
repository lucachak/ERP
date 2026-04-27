package erp.vivian.controller;

import erp.vivian.dto.ServicoPadraoDTO;
import erp.vivian.service.ServicoPadraoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/servicos-padrao")
@RequiredArgsConstructor
public class ServicoPadraoController {

    private final ServicoPadraoService service;

    // Rota para o HTMX salvar e devolver o dropdown atualizado na tela da O.S.
    @PostMapping("/rapido")
    public String salvarRapido(@Valid @ModelAttribute ServicoPadraoDTO dto, Model model) {
        service.salvarServico(dto);
        model.addAttribute("servicosPadrao", service.listarTodos());
        return "os/detalhes :: dropdownServicos";
    }
}