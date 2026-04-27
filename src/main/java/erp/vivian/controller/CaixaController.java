package erp.vivian.controller;

import erp.vivian.dto.TransacaoDTO;
import erp.vivian.model.TransacaoCaixa;
import erp.vivian.repository.TransacaoCaixaRepository;
import erp.vivian.service.CaixaService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/caixa")
@RequiredArgsConstructor
public class CaixaController {

    private final CaixaService service;
    private final TransacaoCaixaRepository repository;

    @GetMapping
    public String index(@RequestParam(required = false) String mesAno, Model model) {
        YearMonth ym = (mesAno != null && !mesAno.isBlank()) ? YearMonth.parse(mesAno) : YearMonth.now();
        LocalDateTime inicio = ym.atDay(1).atStartOfDay();
        LocalDateTime fim = ym.atEndOfMonth().atTime(LocalTime.MAX);

        BigDecimal totalEntradas = repository.somarPorTipo("ENTRADA", inicio, fim);
        BigDecimal totalSaidas = repository.somarPorTipo("SAIDA", inicio, fim);
        BigDecimal saldo = totalEntradas.subtract(totalSaidas);

        model.addAttribute("transacoes", repository.findByDataRegistroBetweenOrderByDataRegistroDesc(inicio, fim));
        model.addAttribute("totalEntradas", totalEntradas);
        model.addAttribute("totalSaidas", totalSaidas);
        model.addAttribute("saldo", saldo);
        model.addAttribute("mesAnoAtual", ym.toString());

        return "caixa/index";
    }

    @PostMapping("/nova")
    public String novaTransacao(@Valid @ModelAttribute TransacaoDTO dto, @RequestParam String mesAnoAtual) {
        service.salvarTransacao(dto);
        return "redirect:/caixa?mesAno=" + mesAnoAtual;
    }

    @PostMapping("/excluir/{id}")
    public String excluirTransacao(@PathVariable Long id, @RequestParam String mesAnoAtual) {
        service.excluirTransacao(id);
        return "redirect:/caixa?mesAno=" + mesAnoAtual;
    }

    // ==========================================
    // ROTA DE EXPORTAÇÃO PARA EXCEL (CSV)
    // ==========================================
    @GetMapping("/exportar")
    public void exportarCsv(@RequestParam(value = "mesAno", required = false) String mesAnoStr,
                            jakarta.servlet.http.HttpServletResponse response) throws java.io.IOException {

        // Interpreta o mês recebido ou usa o mês atual
        YearMonth mesAno = (mesAnoStr != null && !mesAnoStr.isBlank()) ? YearMonth.parse(mesAnoStr) : YearMonth.now();

        // Configura a resposta HTTP para forçar o download de um ficheiro CSV
        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"fluxo_caixa_" + mesAno.toString() + ".csv\"");

        // Prepara o escritor do arquivo
        java.io.PrintWriter writer = response.getWriter();

        // Escreve o BOM do UTF-8 (Este truque garante que o Excel lê os acentos perfeitamente)
        writer.write('\ufeff');

        // Cabeçalho da tabela no Excel (Separado por ponto e vírgula)
        writer.println("Data e Hora;Descrição;Tipo;Valor (R$)");

        // Vai buscar as transações usando o novo método criado no Service
        List<TransacaoCaixa> transacoes = service.buscarTransacoes(mesAno);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        // Escreve cada transação linha a linha
        for (TransacaoCaixa t : transacoes) {
            String data = t.getDataRegistro().format(formatter);
            String descricao = t.getDescricao().replace(";", ","); // Evita quebrar a coluna se houver ";" no texto
            String tipo = t.getTipo();

            // Formata o valor monetário forçando a vírgula para o Excel (Ex: 1500,50)
            String valor = String.format(new java.util.Locale("pt", "BR"), "%.2f", t.getValor());

            // Grava a linha no ficheiro CSV
            writer.println(data + ";" + descricao + ";" + tipo + ";" + valor);
        }
    }
    // Rota que criamos agora para marcar uma conta PENDENTE como PAGA
    @PostMapping("/baixar/{id}")
    public String baixarTransacao(@PathVariable Long id, @RequestParam String mesAnoAtual) {
        service.baixarTransacao(id);
        return "redirect:/caixa?mesAno=" + mesAnoAtual;
    }
}