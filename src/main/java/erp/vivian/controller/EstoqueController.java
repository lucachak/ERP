package erp.vivian.controller;

import erp.vivian.dto.PecaDTO;
import erp.vivian.service.EstoqueService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/estoque")
@RequiredArgsConstructor
public class EstoqueController {

    private final EstoqueService service;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("pecas", service.listarTodas());
        return "estoque/index";
    }

    @GetMapping("/nova")
    public String formularioNovaPeca() {
        return "estoque/form :: formularioPeca";
    }

    @PostMapping("/nova")
    public String salvarPeca(@Valid @ModelAttribute PecaDTO dto, Model model) {
        service.salvarPeca(dto);
        model.addAttribute("pecas", service.listarTodas());
        return "estoque/index :: tabelaEstoque";
    }

    @PostMapping("/rapido")
    public String salvarPecaRapida(@Valid @ModelAttribute PecaDTO dto, Model model) {
        service.salvarPeca(dto);
        model.addAttribute("pecasEstoque", service.listarTodas());
        return "os/detalhes :: dropdownPecas"; // Devolve apenas a caixinha de seleção atualizada!
    }
}