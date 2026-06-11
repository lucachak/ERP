package erp.vivian.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

public class DemoInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String method = request.getMethod();

        // Se a requisição tentar modificar o estado do sistema
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method)) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            // Verifica se o usuário autenticado tem a role DEMO
            if (auth != null && auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_DEMO"))) {
                
                // Se a requisição veio do HTMX, enviamos um script para exibir um alert
                if ("true".equals(request.getHeader("HX-Request"))) {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().write("<script>alert('Acesso Negado: O Modo Demonstração permite apenas leitura! Suas alterações não foram salvas.');</script>");
                } else {
                    // Se foi uma submissão de formulário tradicional
                    response.sendRedirect("/dashboard?demoError=true");
                }
                
                // Bloqueia a execução do controller
                return false;
            }
        }
        
        // Permite a execução normal para métodos GET e para outros usuários
        return true;
    }
}
