CREATE TABLE clientes (
                          id BIGSERIAL PRIMARY KEY,
                          nome VARCHAR(255) NOT NULL,
                          celular VARCHAR(255),
                          telefone VARCHAR(255),
                          email VARCHAR(255),
                          endereco VARCHAR(255),
                          bairro VARCHAR(255),
                          cidade VARCHAR(255),
                          cpf_cnpj VARCHAR(255),
                          rg_ie VARCHAR(255)
);

CREATE TABLE veiculos (
                          id BIGSERIAL PRIMARY KEY,
                          tipo VARCHAR(255),
                          modelo VARCHAR(255) NOT NULL,
                          placa_chassi VARCHAR(255),
                          ano VARCHAR(255),
                          prisma VARCHAR(255),
                          cliente_id BIGINT,
                          CONSTRAINT fk_veiculo_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE ordens_servico (
                                id BIGSERIAL PRIMARY KEY,
                                numero_os VARCHAR(255) UNIQUE NOT NULL,
                                data_emissao TIMESTAMP,
                                data_entrega TIMESTAMP,
                                situacao VARCHAR(255),
                                atendente VARCHAR(255),
                                problema_reclamado TEXT,
                                observacoes TEXT,
                                metodo_pagamento VARCHAR(255),
                                total_servicos NUMERIC(38,2),
                                total_pecas NUMERIC(38,2),
                                frete NUMERIC(38,2),
                                valor_total NUMERIC(38,2),
                                cliente_id BIGINT,
                                veiculo_id BIGINT,
                                CONSTRAINT fk_os_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
                                CONSTRAINT fk_os_veiculo FOREIGN KEY (veiculo_id) REFERENCES veiculos(id)
);

CREATE TABLE itens_servico (
                               id BIGSERIAL PRIMARY KEY,
                               codigo_servico VARCHAR(255),
                               descricao VARCHAR(255) NOT NULL,
                               quantidade DOUBLE PRECISION NOT NULL,
                               unidade VARCHAR(255),
                               valor_unitario NUMERIC(38,2) NOT NULL,
                               valor_total NUMERIC(38,2),
                               tecnico VARCHAR(255),
                               ordem_servico_id BIGINT,
                               CONSTRAINT fk_item_servico_os FOREIGN KEY (ordem_servico_id) REFERENCES ordens_servico(id)
);

CREATE TABLE itens_peca (
                            id BIGSERIAL PRIMARY KEY,
                            codigo_peca VARCHAR(255),
                            descricao VARCHAR(255) NOT NULL,
                            quantidade DOUBLE PRECISION NOT NULL,
                            valor_unitario NUMERIC(38,2) NOT NULL,
                            valor_total NUMERIC(38,2),
                            ordem_servico_id BIGINT,
                            CONSTRAINT fk_item_peca_os FOREIGN KEY (ordem_servico_id) REFERENCES ordens_servico(id)
);