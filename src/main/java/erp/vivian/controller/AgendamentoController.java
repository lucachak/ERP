package erp.vivian.controller;

import erp.vivian.dto.AgendamentoDTO;
import erp.vivian.model.Agendamento;
import erp.vivian.repository.AgendamentoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Controller
@RequestMapping("/agenda")
@RequiredArgsConstructor
public class AgendamentoController {

    private final AgendamentoRepository repository;

    @GetMapping
    public String index(@RequestParam(required = false) String data, Model model) {
        // Se não escolher data, mostra a agenda de hoje
        LocalDate dataBusca = (data != null && !data.isBlank()) ? LocalDate.parse(data) : LocalDate.now();

        LocalDateTime inicioDoDia = dataBusca.atStartOfDay();
        LocalDateTime fimDoDia = dataBusca.atTime(LocalTime.MAX);

        model.addAttribute("agendamentos", repository.findByDataHoraBetweenOrderByDataHoraAsc(inicioDoDia, fimDoDia));
        model.addAttribute("dataAtual", dataBusca.toString()); // Formato YYYY-MM-DD

        return "agenda/index";
    }

    @PostMapping("/novo")
    public String novoAgendamento(@ModelAttribute AgendamentoDTO dto) {
        Agendamento a = new Agendamento();
        a.setNomeCliente(dto.nomeCliente().toUpperCase());
        a.setTelefone(dto.telefone());
        a.setVeiculo(dto.veiculo().toUpperCase());
        a.setServicoDesejado(dto.servicoDesejado());
        a.setDataHora(dto.dataHora());
        a.setStatus("Pendente"); // Nasce sempre pendente

        repository.save(a);

        // Redireciona de volta para a data em que foi marcado o agendamento
        return "redirect:/agenda?data=" + dto.dataHora().toLocalDate().toString();
    }

    @PostMapping("/{id}/status")
    public String atualizarStatus(@PathVariable Long id, @RequestParam String status, @RequestParam String dataAtual) {
        Agendamento a = repository.findById(id).orElseThrow();
        a.setStatus(status);
        repository.save(a);
        return "redirect:/agenda?data=" + dataAtual;
    }
}