package erp.vivian.dto;

import jakarta.validation.constraints.NotBlank;

public record NovaOsDTO(
        Long clienteId, // Adicionado para receber o ID se o cliente já existir

        String clienteNome, // Removido o @NotBlank para não dar erro na validação
        String celular,
        String telefone,
        String email,
        String cpfCnpj,
        String rgIe,
        String endereco,
        String bairro,
        String cidade,

        @NotBlank(message = "O modelo do veículo/equipamento é obrigatório.") String veiculoModelo,
        String placa,
        String ano,
        String prisma,

        @NotBlank(message = "O problema reclamado é obrigatório.") String problemaReclamado,
        String metodoPagamento
) {}