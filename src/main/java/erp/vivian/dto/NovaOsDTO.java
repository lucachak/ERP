package erp.vivian.dto;

public record NovaOsDTO(
        Long clienteId,      // ID de cliente existente (opcional)

        String clienteNome,  // Nome para novo cliente (opcional — modo orçamento anônimo)
        String celular,
        String telefone,
        String email,
        String cpfCnpj,
        String rgIe,
        String endereco,
        String bairro,
        String cidade,

        String veiculoModelo,   // Modelo do veículo/equipamento
        String placa,
        String ano,
        String veiculoCor,
        String prisma,

        String problemaReclamado,
        String metodoPagamento
) {}