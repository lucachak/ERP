package erp.vivian.controller;

import erp.vivian.model.Cliente;
import erp.vivian.service.ClienteService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/clientes")
@RequiredArgsConstructor
public class ClienteController {

    private final ClienteService service;

    @GetMapping
    public String index(@RequestParam(defaultValue = "") String termo,
                        @RequestParam(defaultValue = "0") int page,
                        Model model) {
        Page<Cliente> clientesPage = service.pesquisar(termo, page, 10);
        model.addAttribute("clientesPage", clientesPage);
        model.addAttribute("termo", termo);
        return "clientes/index";
    }

    // Para a busca em tempo real do HTMX
    @GetMapping("/lista")
    public String listarFragmento(@RequestParam(defaultValue = "") String termo,
                                  @RequestParam(defaultValue = "0") int page,
                                  Model model) {
        Page<Cliente> clientesPage = service.pesquisar(termo, page, 10);
        model.addAttribute("clientesPage", clientesPage);
        model.addAttribute("termo", termo);
        return "clientes/index :: tabelaClientes";
    }

    // Retorna APENAS o HTML do formulário quando clicamos em "Novo Cliente"
    @GetMapping("/novo")
    public String formularioNovoCliente() {
        return "clientes/form :: formularioCliente";
    }

    // Recebe os dados do formulário, salva e atualiza a tabela em tempo real
    @PostMapping("/novo")
    public String salvarCliente(Cliente cliente, Model model) {
        service.salvar(cliente);

        // Atualiza a tabela imediatamente após salvar
        Page<Cliente> clientesPage = service.pesquisar("", 0, 10);
        model.addAttribute("clientesPage", clientesPage);
        model.addAttribute("termo", "");
        return "clientes/index :: tabelaClientes";
    }

    // A Ficha Completa do Cliente (CRM)
    @GetMapping("/{id}")
    public String fichaCliente(@PathVariable Long id, Model model) {
        Cliente cliente = service.buscarPorId(id);
        model.addAttribute("cliente", cliente);
        model.addAttribute("historicoOs", service.buscarHistoricoOs(id));
        return "clientes/detalhes";
    }
    @PostMapping("/{id}/editar")
    public String editarCliente(@PathVariable Long id, Cliente dadosAtualizados) {
        service.atualizar(id, dadosAtualizados);

        // Redireciona de volta para a ficha do cliente atualizada
        return "redirect:/clientes/" + id;
    }
}