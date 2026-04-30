package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;

public record UsuarioDTO(
        Long id,
        @NotBlank(message = "O nome de utilizador é obrigatório.") String username,
        String password,
        String role
) {}
