package erp.vivian.controller;

import erp.vivian.dto.ServicoPadraoDTO;
import erp.vivian.service.ServicoPadraoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/servicos-padrao")
@RequiredArgsConstructor
public class ServicoPadraoController {

    private final ServicoPadraoService service;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("servicos", service.listarTodos());
        return "servicos/index";
    }

    @PostMapping("/salvar")
    public String salvar(@Valid @ModelAttribute ServicoPadraoDTO dto) {
        service.salvarServico(dto);
        return "redirect:/servicos-padrao";
    }

    @DeleteMapping("/{id}/excluir")
    @ResponseBody
    public String excluir(@PathVariable Long id) {
        service.excluir(id);
        return "";
    }

    // Rota para o HTMX salvar e devolver o dropdown atualizado na tela da O.S.
    @PostMapping("/rapido")
    public String salvarRapido(@Valid @ModelAttribute ServicoPadraoDTO dto, Model model) {
        service.salvarServico(dto);
        model.addAttribute("servicosPadrao", service.listarTodos());
        return "os/detalhes :: dropdownServicos";
    }
}