package erp.vivian.exception;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;
import org.springframework.validation.BindException; // <-- A correção principal está aqui
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    // Agora sim, captura os erros de @Valid vindos dos formulários (@ModelAttribute)
    @ExceptionHandler(BindException.class)
    public String handleValidationExceptions(BindException ex, HttpServletResponse response, Model model) {
        String erro = ex.getBindingResult().getFieldErrors().get(0).getDefaultMessage();
        return dispararToast(erro, response, model);
    }

    @ExceptionHandler({IllegalStateException.class, IllegalArgumentException.class})
    public String handleBusinessExceptions(RuntimeException ex, HttpServletResponse response, Model model) {
        return dispararToast(ex.getMessage(), response, model);
    }

    private String dispararToast(String mensagem, HttpServletResponse response, Model model) {
        model.addAttribute("mensagemErro", mensagem);

        response.setHeader("HX-Retarget", "#toast-container");
        response.setHeader("HX-Reswap", "innerHTML");
        response.setStatus(HttpServletResponse.SC_OK);

        return "fragmentos/toast :: erroToast";
    }
}