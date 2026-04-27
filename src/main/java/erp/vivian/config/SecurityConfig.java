package erp.vivian.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // Desativamos o CSRF temporariamente para não bloquear os pedidos do HTMX
                .csrf(csrf -> csrf.disable())


                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login", "/css/**", "/js/**", "/img/**").permitAll()
                        // APENAS O CHEFE (ADMIN) PODE ENTRAR AQUI:
                        .requestMatchers("/caixa/**", "/relatorios/**", "/usuarios/**", "/backup/**", "/", "/dashboard", "/agenda/**", "/os/kanban").hasRole("ADMIN")
                        // O RESTO É LIVRE PARA QUEM ESTIVER LOGADO (Mecânicos):
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        // PÁGINA INICIAL: LISTA DE SERVIÇOS
                        .defaultSuccessUrl("/os", true)
                        .permitAll()
                )



                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout") // Volta para o login após sair
                        .permitAll()
                );

        return http.build();
    }

    // Configura o encriptador de senhas (BCrypt)
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}