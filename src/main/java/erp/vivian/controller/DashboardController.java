package erp.vivian.controller;

import erp.vivian.model.OrdemServico;
import erp.vivian.repository.OrdemServicoRepository;
import erp.vivian.repository.PecaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final OrdemServicoRepository osRepository;
    private final PecaRepository pecaRepository;

    @GetMapping({"/", "/dashboard"})
    public String dashboard(Model model) {
        LocalDateTime inicioMes = LocalDate.now().withDayOfMonth(1).atStartOfDay();
        LocalDateTime fimMes = LocalDate.now().withDayOfMonth(LocalDate.now().lengthOfMonth()).atTime(LocalTime.MAX);

        BigDecimal faturamentoMensal = osRepository.somarFaturamentoMensal(inicioMes, fimMes);
        long osAbertas = osRepository.countBySituacao("Aberta");
        long alertasEstoque = pecaRepository.countByQuantidadeEstoqueLessThanEqual(2.0);

        List<OrdemServico> encerradasList = osRepository.findBySituacao("Encerrada");
        long totalHoras = 0;
        int osValidas = 0;
        for (OrdemServico o : encerradasList) {
            if (o.getDataEntrega() != null && o.getDataEmissao() != null) {
                totalHoras += java.time.Duration.between(o.getDataEmissao(), o.getDataEntrega()).toHours();
                osValidas++;
            }
        }
        long tempoMedioHoras = osValidas == 0 ? 0 : totalHoras / osValidas;

        // --- NOVO: LÓGICA PARA OS GRÁFICOS ---

        // 1. Gráfico de Rosca (Status das O.S.)
        model.addAttribute("qtdAberta", osAbertas);
        model.addAttribute("qtdAguardando", osRepository.countBySituacao("Aguardando Peça"));
        model.addAttribute("qtdServico", osRepository.countBySituacao("Em Serviço"));
        model.addAttribute("qtdEncerrada", osRepository.countBySituacao("Encerrada"));

        // 2. Gráfico de Barras (Faturamento dos últimos 6 meses)
        List<String> meses = new ArrayList<>();
        List<BigDecimal> faturamentos = new ArrayList<>();
        YearMonth mesAtual = YearMonth.now();
        Locale ptBR = new Locale("pt", "BR");

        // Faz um loop de 5 até 0 para pegar os meses de trás para a frente
        for (int i = 5; i >= 0; i--) {
            YearMonth mesAlvo = mesAtual.minusMonths(i);
            LocalDateTime inicio = mesAlvo.atDay(1).atStartOfDay();
            LocalDateTime fim = mesAlvo.atEndOfMonth().atTime(LocalTime.MAX);

            String nomeMes = mesAlvo.getMonth().getDisplayName(TextStyle.SHORT, ptBR) + "/" + mesAlvo.getYear();
            meses.add(nomeMes.toUpperCase());
            faturamentos.add(osRepository.somarFaturamentoMensal(inicio, fim));
        }

        model.addAttribute("chartMeses", meses);
        model.addAttribute("chartFaturamentos", faturamentos);

        // --- FIM DA LÓGICA DOS GRÁFICOS ---

        model.addAttribute("faturamentoMensal", faturamentoMensal);
        model.addAttribute("osAbertas", osAbertas);
        model.addAttribute("alertasEstoque", alertasEstoque);
        model.addAttribute("tempoMedioHoras", tempoMedioHoras);
        model.addAttribute("ultimasOs", osRepository.findTop5ByOrderByDataEmissaoDesc());

        return "dashboard/index";
    }
}