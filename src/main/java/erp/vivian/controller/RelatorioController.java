package erp.vivian.controller;

import erp.vivian.repository.ItemServicoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;

@Controller
@RequestMapping("/relatorios")
@RequiredArgsConstructor
public class RelatorioController {

    private final ItemServicoRepository itemServicoRepository;

    @GetMapping("/comissoes")
    public String comissoes(@RequestParam(required = false) String mesAno, Model model) {
        // Se o usuário não escolher um mês, pegamos o mês atual por padrão
        YearMonth ym = (mesAno != null && !mesAno.isBlank()) ? YearMonth.parse(mesAno) : YearMonth.now();

        // Define o primeiro segundo e o último segundo do mês
        LocalDateTime inicio = ym.atDay(1).atStartOfDay();
        LocalDateTime fim = ym.atEndOfMonth().atTime(LocalTime.MAX);

        var relatorio = itemServicoRepository.gerarRelatorioComissoes(inicio, fim);

        model.addAttribute("relatorio", relatorio);
        model.addAttribute("mesAnoAtual", ym.toString()); // Formato YYYY-MM

        return "relatorios/comissoes";
    }
}