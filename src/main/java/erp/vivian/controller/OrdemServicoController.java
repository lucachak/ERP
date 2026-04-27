package erp.vivian.controller;

import erp.vivian.repository.ClienteRepository;
import erp.vivian.service.EstoqueService;
import erp.vivian.dto.ItemPecaDTO;
import erp.vivian.dto.ItemServicoDTO;
import erp.vivian.dto.NovaOsDTO;
import erp.vivian.dto.OsExtraInfoDTO;
import erp.vivian.model.OrdemServico;
import erp.vivian.service.OrdemServicoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/os")
@RequiredArgsConstructor
public class OrdemServicoController {

    private final OrdemServicoService service;
    private final EstoqueService estoqueService;
    private final erp.vivian.service.ServicoPadraoService servicoPadraoService;
    private final ClienteRepository clienteRepository; // INJETADO PARA LISTAR OS CLIENTES

    @GetMapping
    public String index(@RequestParam(defaultValue = "") String termo,
                        @RequestParam(defaultValue = "0") int page,
                        Model model) {
        Page<OrdemServico> ordensPage = service.pesquisar(termo, page, 10);
        model.addAttribute("ordensPage", ordensPage);
        model.addAttribute("termo", termo);
        return "os/index";
    }

    @GetMapping("/lista")
    public String listarFragmento(@RequestParam(defaultValue = "") String termo,
                                  @RequestParam(defaultValue = "0") int page,
                                  Model model) {
        Page<OrdemServico> ordensPage = service.pesquisar(termo, page, 10);
        model.addAttribute("ordensPage", ordensPage);
        model.addAttribute("termo", termo);
        return "os/index :: tabelaOS";
    }

    // CARREGA A TELA DE NOVA O.S.
    @GetMapping("/nova")
    public String formularioNovaOs(Model model) {
        // Manda os clientes ordenados alfabeticamente para o <select> da tela
        model.addAttribute("clientes", clienteRepository.findAll(Sort.by("nome")));
        return "os/form"; // Removemos o :: formulario, carrega a tela inteira agora
    }

    // SALVA A NOVA O.S. E REDIRECIONA
    @PostMapping("/nova")
    public String salvarNovaOs(@Valid @ModelAttribute NovaOsDTO novaOsDTO) {
        OrdemServico novaOs = service.criarNovaOs(novaOsDTO);
        // MÁGICA: Redireciona direto para a página de detalhes da nova O.S.
        return "redirect:/os/" + novaOs.getId();
    }

    @GetMapping("/{id}")
    public String detalhesOs(@PathVariable Long id, Model model) {
        model.addAttribute("os", service.buscarPorId(id));
        model.addAttribute("pecasEstoque", estoqueService.listarTodas());
        model.addAttribute("servicosPadrao", servicoPadraoService.listarTodos());
        return "os/detalhes";
    }

    @PostMapping("/{id}/servicos")
    public String adicionarServico(@PathVariable Long id, @Valid @ModelAttribute ItemServicoDTO dto, Model model) {
        OrdemServico osAtualizada = service.adicionarServico(id, dto);
        model.addAttribute("os", osAtualizada);
        return "os/detalhes :: painelDinamico";
    }

    @PostMapping("/{id}/fechar")
    public String fecharOs(@PathVariable Long id, Model model) {
        OrdemServico osAtualizada = service.fecharOs(id);
        model.addAttribute("os", osAtualizada);
        model.addAttribute("pecasEstoque", estoqueService.listarTodas());
        model.addAttribute("servicosPadrao", servicoPadraoService.listarTodos());
        return "os/detalhes :: osCompleta";
    }

    @GetMapping("/{id}/imprimir")
    public String imprimirOs(@PathVariable Long id, Model model) {
        model.addAttribute("os", service.buscarPorId(id));
        return "os/impressao";
    }

    @PostMapping("/{id}/pecas")
    public String adicionarPeca(@PathVariable Long id, @Valid @ModelAttribute ItemPecaDTO dto, Model model) {
        OrdemServico osAtualizada = service.adicionarPeca(id, dto);
        model.addAttribute("os", osAtualizada);
        return "os/detalhes :: painelDinamico";
    }

    @PostMapping("/{id}/extras")
    public String atualizarExtras(@PathVariable Long id, @Valid @ModelAttribute OsExtraInfoDTO dto, Model model) {
        OrdemServico osAtualizada = service.atualizarExtras(id, dto);
        model.addAttribute("os", osAtualizada);
        model.addAttribute("pecasEstoque", estoqueService.listarTodas());
        model.addAttribute("servicosPadrao", servicoPadraoService.listarTodos());
        return "os/detalhes :: osCompleta";
    }

    @DeleteMapping("/{id}/servicos/{servicoId}")
    public String removerServico(@PathVariable Long id, @PathVariable Long servicoId, Model model) {
        OrdemServico osAtualizada = service.removerServico(id, servicoId);
        model.addAttribute("os", osAtualizada);
        return "os/detalhes :: painelDinamico";
    }

    @DeleteMapping("/{id}/pecas/{pecaId}")
    public String removerPeca(@PathVariable Long id, @PathVariable Long pecaId, Model model) {
        OrdemServico osAtualizada = service.removerPeca(id, pecaId);
        model.addAttribute("os", osAtualizada);
        return "os/detalhes :: painelDinamico";
    }

    @GetMapping("/kanban")
    public String kanban(@RequestParam(value = "termo", required = false) String termo, Model model) {
        preencherModeloKanban(model, termo);
        model.addAttribute("termo", termo);
        return "os/kanban";
    }

    @PostMapping("/{id}/situacao")
    public String atualizarSituacao(@PathVariable Long id,
                                    @RequestParam String novaSituacao,
                                    @RequestParam(value = "termo", required = false) String termo,
                                    Model model) {
        service.atualizarSituacao(id, novaSituacao);
        preencherModeloKanban(model, termo);
        model.addAttribute("termo", termo);
        return "os/kanban :: quadroKanban";
    }

    private void preencherModeloKanban(Model model, String termo) {
        model.addAttribute("abertas", service.buscarNoKanban("Aberta", termo));
        model.addAttribute("aguardando", service.buscarNoKanban("Aguardando Peça", termo));
        model.addAttribute("emServico", service.buscarNoKanban("Em Serviço", termo));
        List<OrdemServico> encerradas = service.buscarNoKanban("Encerrada", termo).stream()
                .sorted((o1, o2) -> o2.getId().compareTo(o1.getId()))
                .limit(15)
                .toList();
        model.addAttribute("encerradas", encerradas);
    }
}