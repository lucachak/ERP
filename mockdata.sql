-- =============================================================
--  CAMBIOMATIC — MOCK DATA SEED SCRIPT
--  Compatible with NeonDB (PostgreSQL)
--  Generated: 2026-06-11
--
--  ATENÇÃO: Este script LIMPA todos os dados existentes antes
--  de inserir os dados de mock. Use apenas em ambiente de DEV.
-- =============================================================

-- ─────────────────────────────────────────────────────────────
--  1. LIMPEZA (ordem inversa de dependências FK)
-- ─────────────────────────────────────────────────────────────
TRUNCATE TABLE itens_peca         RESTART IDENTITY CASCADE;
TRUNCATE TABLE itens_servico      RESTART IDENTITY CASCADE;
TRUNCATE TABLE ordens_servico     RESTART IDENTITY CASCADE;
TRUNCATE TABLE veiculos           RESTART IDENTITY CASCADE;
TRUNCATE TABLE clientes           RESTART IDENTITY CASCADE;
TRUNCATE TABLE agendamentos       RESTART IDENTITY CASCADE;
TRUNCATE TABLE pecas              RESTART IDENTITY CASCADE;
TRUNCATE TABLE servicos_padrao    RESTART IDENTITY CASCADE;
TRUNCATE TABLE transacoes_caixa   RESTART IDENTITY CASCADE;
TRUNCATE TABLE usuarios           RESTART IDENTITY CASCADE;


-- ─────────────────────────────────────────────────────────────
--  2. USUÁRIOS (senhas são BCrypt de "senha123")
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuarios (username, password, role) VALUES
('lucas.admin',       '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ADMIN'),
('vivian.gerente',    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ADMIN'),
('luiz.tecnico',      '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ATENDENTE'),
('ana.atendente',     '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ATENDENTE'),
('pedro.mecanico',    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ATENDENTE'),
('carlos.supervisor', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ADMIN'),
('fernanda.staff',    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHuu', 'ROLE_ATENDENTE');


-- ─────────────────────────────────────────────────────────────
--  3. CLIENTES (40 clientes)
-- ─────────────────────────────────────────────────────────────
INSERT INTO clientes (nome, celular, telefone, email, endereco, bairro, cidade, cpf_cnpj, rg_ie) VALUES
('João Carlos Pereira',     '(11) 99234-5678', '(11) 3456-7890', 'joao.pereira@email.com',      'Rua das Acácias, 142',        'Jardim Paulista',   'São Paulo',       '123.456.789-01', '12.345.678-9'),
('Maria Fernanda Santos',   '(11) 98765-4321', '(11) 3234-5678', 'mfernanda@gmail.com',          'Av. Brasil, 890',             'Centro',            'Santo André',     '234.567.890-12', '23.456.789-0'),
('Roberto Alves Souza',     '(11) 97654-3210', '(11) 4567-8901', 'roberto.souza@hotmail.com',    'Rua Ipiranga, 55',            'Vila Madalena',     'São Paulo',       '345.678.901-23', '34.567.890-1'),
('Patrícia Lima Costa',     '(11) 96543-2109', '(11) 5678-9012', 'patricia.costa@yahoo.com',     'Rua Consolação, 320',         'Consolação',        'São Paulo',       '456.789.012-34', '45.678.901-2'),
('Carlos Eduardo Martins',  '(11) 95432-1098', '(11) 6789-0123', 'carlos.martins@empresa.com',   'Rua Augusta, 1200',           'Bela Vista',        'São Paulo',       '567.890.123-45', '56.789.012-3'),
('Ana Beatriz Rodrigues',   '(11) 94321-0987', '(11) 7890-1234', 'ana.rodrigues@outlook.com',    'Rua Oscar Freire, 440',       'Jardins',           'São Paulo',       '678.901.234-56', '67.890.123-4'),
('Felipe Mendes Oliveira',  '(11) 93210-9876', '(11) 8901-2345', 'felipe.mendes@gmail.com',      'Av. Paulista, 1578',          'Bela Vista',        'São Paulo',       '789.012.345-67', '78.901.234-5'),
('Juliana Castro Ferreira', '(11) 92109-8765', '(11) 9012-3456', 'juliana.ferreira@email.com',   'Rua Tutóia, 78',              'Paraíso',           'São Paulo',       '890.123.456-78', '89.012.345-6'),
('Marcelo Pinto Nunes',     '(11) 91098-7654', '(11) 2345-6789', 'marcelo.nunes@empresa.com.br', 'Rua Dr. Melo Alves, 230',     'Cerqueira César',   'São Paulo',       '901.234.567-89', '90.123.456-7'),
('Sandra Aparecida Torres', '(11) 90987-6543', '(11) 3456-7891', 'sandra.torres@hotmail.com',    'Av. Rebouças, 555',           'Pinheiros',         'São Paulo',       '012.345.678-90', '01.234.567-8'),
('Lucas Henrique Barros',   '(11) 99876-5432', '(11) 4567-8902', 'lucas.barros@gmail.com',       'Rua Teodoro Sampaio, 890',    'Pinheiros',         'São Paulo',       '111.222.333-44', '11.222.333-4'),
('Camila Rocha Andrade',    '(11) 98765-4320', '(11) 5678-9013', 'camila.andrade@yahoo.com',     'Rua Padre João Manoel, 120',  'Jardins',           'São Paulo',       '222.333.444-55', '22.333.444-5'),
('Thiago Gomes Cardoso',    '(11) 97654-3219', '(11) 6789-0124', 'thiago.gomes@outlook.com',     'Av. Morumbi, 2400',           'Morumbi',           'São Paulo',       '333.444.555-66', '33.444.555-6'),
('Renata Silva Monteiro',   '(11) 96543-2108', '(11) 7890-1235', 'renata.monteiro@gmail.com',    'Rua das Flores, 33',          'Vila Clementino',   'São Paulo',       '444.555.666-77', '44.555.666-7'),
('Diego Nascimento Lopes',  '(11) 95432-1097', '(11) 8901-2346', 'diego.lopes@empresa.com',      'Av. Brigadeiro Luís Antônio, 98', 'Bela Vista',   'São Paulo',       '555.666.777-88', '55.666.777-8'),
('Vanessa Ribeiro Cruz',    '(11) 94321-0986', '(11) 9012-3457', 'vanessa.cruz@hotmail.com',     'Rua Haddock Lobo, 250',       'Cerqueira César',   'São Paulo',       '666.777.888-99', '66.777.888-9'),
('Eduardo Araujo Dias',     '(11) 93210-9875', '(11) 2345-6780', 'eduardo.dias@gmail.com',       'Rua Pamplona, 590',           'Jardim Paulista',   'São Paulo',       '777.888.999-00', '77.888.999-0'),
('Mariana Lima Vaz',        '(11) 92109-8764', '(11) 3456-7892', 'mariana.vaz@email.com',        'Rua Joaquim Floriano, 820',   'Itaim Bibi',        'São Paulo',       '888.999.000-11', '88.999.000-1'),
('Bruno Freitas Teixeira',  '(11) 91098-7653', '(11) 4567-8903', 'bruno.teixeira@yahoo.com',     'Rua Bela Cintra, 340',        'Consolação',        'São Paulo',       '999.000.111-22', '99.000.111-2'),
('Larissa Borges Pires',    '(11) 90987-6542', '(11) 5678-9014', 'larissa.pires@outlook.com',    'Av. Europa, 170',             'Jardim Europa',     'São Paulo',       '100.200.300-40', '10.020.030-4'),
('Gustavo Moraes Cunha',    '(21) 99234-1234', '(21) 3456-5678', 'gustavo.cunha@gmail.com',      'Rua Visconde de Pirajá, 500', 'Ipanema',           'Rio de Janeiro',  '200.300.400-50', '20.030.040-5'),
('Fernanda Alves Ramos',    '(21) 98765-2345', '(21) 3234-6789', 'fernanda.ramos@hotmail.com',   'Av. Atlântica, 1702',         'Copacabana',        'Rio de Janeiro',  '300.400.500-60', '30.040.050-6'),
('Rafael Pereira Gomes',    '(21) 97654-3456', '(21) 4567-7890', 'rafael.gomes@email.com',       'Rua Barata Ribeiro, 450',     'Copacabana',        'Rio de Janeiro',  '400.500.600-70', '40.050.060-7'),
('Isabela Sousa Melo',      '(21) 96543-4567', '(21) 5678-8901', 'isabela.melo@yahoo.com',       'Rua Farme de Amoedo, 82',     'Ipanema',           'Rio de Janeiro',  '500.600.700-80', '50.060.070-8'),
('André Cardoso Machado',   '(21) 95432-5678', '(21) 6789-9012', 'andre.machado@outlook.com',    'Rua Voluntários da Pátria, 74', 'Botafogo',        'Rio de Janeiro',  '600.700.800-90', '60.070.080-9'),
('Simone Campos Brandão',   '(31) 99234-6789', '(31) 3456-4567', 'simone.brandao@gmail.com',     'Av. Afonso Pena, 1500',       'Centro',            'Belo Horizonte',  '700.800.900-01', '70.080.090-0'),
('Henrique Moreira Neto',   '(31) 98765-7890', '(31) 3234-5679', 'henrique.neto@empresa.com',    'Rua da Bahia, 780',           'Lourdes',           'Belo Horizonte',  '800.900.010-12', '80.090.010-1'),
('Priscila Fonseca Rocha',  '(41) 99234-8901', '(41) 3456-3456', 'priscila.rocha@gmail.com',     'Rua XV de Novembro, 200',     'Centro',            'Curitiba',        '900.010.120-23', '90.010.012-2'),
('Rodrigo Vieira Matos',    '(41) 98765-9012', '(41) 3234-4567', 'rodrigo.matos@hotmail.com',    'Av. Batel, 1000',             'Batel',             'Curitiba',        '010.120.230-34', '01.012.023-3'),
('Aline Batista Corrêa',    '(51) 99234-0123', '(51) 3456-2345', 'aline.correa@email.com',       'Av. Ipiranga, 400',           'Centro',            'Porto Alegre',    '120.230.340-45', '12.023.034-4'),
('Vinícius Carvalho Leite', '(51) 98765-1234', '(51) 3234-3456', 'vinicius.leite@yahoo.com',     'Rua dos Andradas, 900',       'Centro Histórico',  'Porto Alegre',    '230.340.450-56', '23.034.045-5'),
('Daniela Ramos Xavier',    '(85) 99234-2345', '(85) 3456-1234', 'daniela.xavier@gmail.com',     'Av. Beira Mar, 3000',         'Meireles',          'Fortaleza',       '340.450.560-67', '34.045.056-6'),
('Fábio Nascimento Pinto',  '(85) 98765-3456', '(85) 3234-2345', 'fabio.pinto@outlook.com',      'Rua Monsenhor Bruno, 600',    'Aldeota',           'Fortaleza',       '450.560.670-78', '45.056.067-7'),
('Tatiana Coelho Duarte',   '(61) 99234-4567', '(61) 3456-0123', 'tatiana.duarte@gmail.com',     'SQN 315 Bloco C Ap. 102',     'Asa Norte',         'Brasília',        '560.670.780-89', '56.067.078-8'),
('Márcio Silva Rezende',    '(61) 98765-5678', '(61) 3234-1234', 'marcio.rezende@hotmail.com',   'SQS 208 Bloco B Ap. 401',     'Asa Sul',           'Brasília',        '670.780.890-90', '67.078.089-9'),
('Cristiane Mendes Lacerda','(81) 99234-6789', '(81) 3456-9012', 'cristiane.lacerda@yahoo.com',  'Rua do Bom Jesus, 200',       'Recife Antigo',     'Recife',          '780.890.900-01', '78.089.090-0'),
('Leandro Ferreira Lins',   '(81) 98765-7890', '(81) 3234-0123', 'leandro.lins@email.com',       'Av. Boa Viagem, 2000',        'Boa Viagem',        'Recife',          '890.900.010-12', '89.090.001-1'),
('Monique Costa Trajano',   '(92) 99234-8901', '(92) 3456-7890', 'monique.trajano@gmail.com',    'Av. Eduardo Ribeiro, 520',    'Centro',            'Manaus',          '900.010.120-23', '90.001.012-2'),
('Renato Augusto Moraes',   '(62) 99234-9012', '(62) 3456-6789', 'renato.moraes@hotmail.com',    'Av. Goiás, 1500',             'Setor Central',     'Goiânia',         '010.120.230-34', '01.012.023-3'),
('Bianca Teixeira Almeida', '(71) 99234-0123', '(71) 3456-5678', 'bianca.almeida@gmail.com',     'Av. Tancredo Neves, 1632',    'Caminho das Árvores','Salvador',       '120.230.340-45', '12.023.034-4');


-- ─────────────────────────────────────────────────────────────
--  4. VEÍCULOS (múltiplos por cliente)
-- ─────────────────────────────────────────────────────────────
INSERT INTO veiculos (tipo, modelo, placa_chassi, ano, cor, prisma, cliente_id) VALUES
-- Clientes 1-10
('Carro',    'Volkswagen Gol 1.0',        'ABC-1234', '2019', 'Branco',  'Hatchback', 1),
('Carro',    'Honda Civic EX',            'DEF-5678', '2021', 'Prata',   'Sedan',     2),
('Carro',    'Toyota Corolla XEi',        'GHI-9012', '2020', 'Preto',   'Sedan',     3),
('SUV',      'Hyundai Creta Smart',       'JKL-3456', '2022', 'Branco',  'SUV',       4),
('Carro',    'Chevrolet Onix Plus LTZ',   'MNO-7890', '2023', 'Vermelho','Sedan',     5),
('Carro',    'Fiat Argo Drive',           'PQR-1234', '2020', 'Azul',    'Hatchback', 6),
('SUV',      'Jeep Compass Limited',      'STU-5678', '2021', 'Cinza',   'SUV',       7),
('Carro',    'Nissan Sentra SV',          'VWX-9012', '2022', 'Prata',   'Sedan',     8),
('Picape',   'Chevrolet S10 High Country','YZA-3456', '2020', 'Preto',   'Picape',    9),
('Carro',    'Ford Ka SE',                'BCD-7890', '2019', 'Vermelho','Hatchback', 10),
-- Clientes 11-20
('SUV',      'Volkswagen T-Cross Comfortline','EFG-1234','2023','Branco', 'SUV',      11),
('Carro',    'Toyota Yaris XLS',          'HIJ-5678', '2021', 'Cinza',   'Sedan',     12),
('Carro',    'Renault Kwid Intense',      'KLM-9012', '2020', 'Laranja', 'Hatchback', 13),
('SUV',      'Kia Sportage EX',           'NOP-3456', '2022', 'Azul',    'SUV',       14),
('Carro',    'Fiat Pulse Drive',          'QRS-7890', '2023', 'Branco',  'SUV',       15),
('Carro',    'Chevrolet Cruze Sport6 LT', 'TUV-1234', '2021', 'Prata',   'Hatchback', 16),
('Carro',    'Honda HRV EX',              'WXY-5678', '2022', 'Vermelho','SUV',       17),
('Carro',    'Volkswagen Polo GTS',       'ZAB-9012', '2023', 'Preto',   'Hatchback', 18),
('SUV',      'Toyota RAV4 Adventure',     'CDE-3456', '2020', 'Cinza',   'SUV',       19),
('Picape',   'Ford Ranger XLS',           'FGH-7890', '2022', 'Branco',  'Picape',    20),
-- Clientes 21-30
('Carro',    'Fiat Fastback Turbo 200',   'IJK-1234', '2023', 'Vermelho','Hatchback', 21),
('SUV',      'Jeep Renegade Sport',       'LMN-5678', '2021', 'Verde',   'SUV',       22),
('Carro',    'Hyundai HB20 Diamond',      'OPQ-9012', '2022', 'Azul',    'Hatchback', 23),
('Carro',    'Chevrolet Onix LT',         'RST-3456', '2020', 'Prata',   'Hatchback', 24),
('SUV',      'Mitsubishi Eclipse Cross',  'UVW-7890', '2021', 'Preto',   'SUV',       25),
('Carro',    'Volkswagen Virtus Comfortline','XYZ-1234','2022','Branco',  'Sedan',     26),
('Carro',    'Toyota Etios Sedan X',      'ABC-4567', '2019', 'Cinza',   'Sedan',     27),
('SUV',      'Nissan Kicks Exclusive',    'DEF-8901', '2023', 'Vermelho','SUV',       28),
('Carro',    'Renault Sandero Stepway',   'GHI-2345', '2020', 'Laranja', 'Hatchback', 29),
('Picape',   'Toyota Hilux SRX',          'JKL-6789', '2022', 'Preto',   'Picape',    30),
-- Clientes 31-40
('Carro',    'Fiat Mobi Like',            'MNO-0123', '2021', 'Azul',    'Hatchback', 31),
('Carro',    'Honda Fit EX',              'PQR-4567', '2020', 'Prata',   'Hatchback', 32),
('SUV',      'Ford Territory Titanium',   'STU-8901', '2023', 'Branco',  'SUV',       33),
('Carro',    'Chevrolet Cobalt LTZ',      'VWX-2345', '2019', 'Cinza',   'Sedan',     34),
('Carro',    'Hyundai i30 N Line',        'YZA-6789', '2022', 'Vermelho','Hatchback', 35),
('SUV',      'Kia Seltos EX',             'BCD-0123', '2023', 'Preto',   'SUV',       36),
('Carro',    'Toyota Corolla Altis',      'EFG-4567', '2021', 'Prata',   'Sedan',     37),
('Carro',    'Volkswagen Golf GTI',       'HIJ-8901', '2020', 'Cinza',   'Hatchback', 38),
('Picape',   'Fiat Toro Ranch',           'KLM-2345', '2022', 'Vermelho','Picape',    39),
('SUV',      'Renault Duster Iconic',     'NOP-6789', '2021', 'Azul',    'SUV',       40),
-- Veículos extras (segundo carro de alguns clientes)
('Moto',     'Honda CB 500F',             'QRS-0123', '2021', 'Vermelho','Naked',      1),
('Carro',    'Ford EcoSport FreeStyle',   'TUV-4567', '2019', 'Prata',   'SUV',        5),
('Carro',    'Volkswagen Jetta Comfortline','WXY-8901','2020','Preto',    'Sedan',      9);


-- ─────────────────────────────────────────────────────────────
--  5. PEÇAS NO ESTOQUE
-- ─────────────────────────────────────────────────────────────
INSERT INTO pecas (codigo, descricao, quantidade_estoque, preco_custo, preco_venda) VALUES
-- Filtros
('FIL-001', 'Filtro de Óleo Bosch F026407123',          12.0,  18.50,  38.00),
('FIL-002', 'Filtro de Ar Mann C25117',                   8.0,  22.00,  45.00),
('FIL-003', 'Filtro de Cabine Mahle LA258',              15.0,  24.00,  52.00),
('FIL-004', 'Filtro de Combustível WEG KL174',            6.0,  35.00,  72.00),
('FIL-005', 'Filtro de Ar Condicionado Denso',           10.0,  28.00,  58.00),
-- Óleos e Fluidos
('OLE-001', 'Óleo Motor Mobil 5W30 Sintético 1L',        48.0,  28.00,  55.00),
('OLE-002', 'Óleo Motor Castrol 5W40 Full Sintético 1L', 36.0,  32.00,  62.00),
('OLE-003', 'Óleo Motor Shell Helix 10W40 Semi-Sint. 1L',24.0,  22.00,  44.00),
('OLE-004', 'Fluido de Freio DOT 4 Bosch 500ml',         18.0,  24.00,  48.00),
('OLE-005', 'Fluido de Arrefecimento Basf 1L',           20.0,  18.00,  36.00),
('OLE-006', 'Fluido de Direção Hidráulica Texaco 1L',    14.0,  26.00,  52.00),
-- Freios
('FRE-001', 'Pastilha de Freio Dianteira Fremax BD5108', 8.0,   58.00, 120.00),
('FRE-002', 'Pastilha de Freio Traseira Fremax BD5112',  6.0,   52.00, 108.00),
('FRE-003', 'Disco de Freio Dianteiro Hipper Freios',    4.0,  145.00, 298.00),
('FRE-004', 'Disco de Freio Traseiro Hipper Freios',     4.0,  138.00, 285.00),
('FRE-005', 'Fluido de Freio DOT 3 Motul 500ml',        10.0,   18.00,  38.00),
-- Correia e Sistema de Distribuição
('COR-001', 'Correia Dentada Gates PowerGrip K075355',   3.0,   82.00, 168.00),
('COR-002', 'Kit Correia + Tensionador + Correia Aux',   2.0,  245.00, 498.00),
('COR-003', 'Correia Alternador/Acessórios Gates',        5.0,   45.00,  92.00),
('COR-004', 'Tensor Correia Dentada INA',                 3.0,   78.00, 160.00),
-- Velas e Ignição
('VEL-001', 'Vela de Ignição NGK BKR5EK (unitária)',    32.0,   14.00,  29.00),
('VEL-002', 'Vela de Ignição Bosch FR7DC (unitária)',   24.0,   12.00,  25.00),
('VEL-003', 'Vela Iridium NGK ILZFR6D11 (unitária)',    16.0,   32.00,  65.00),
('VEL-004', 'Cabo de Vela NGK RC-BX108',                 6.0,   78.00, 160.00),
-- Suspensão
('SUS-001', 'Amortecedor Dianteiro Cofap Kayaba',        2.0,  245.00, 498.00),
('SUS-002', 'Amortecedor Traseiro Monroe Matic',          2.0,  198.00, 405.00),
('SUS-003', 'Bandeja Dianteira Direita TRW',              1.0,  320.00, 650.00),
('SUS-004', 'Bucha Bandeja Dianteira Febest',             8.0,   24.00,  49.00),
('SUS-005', 'Kit Pivô Dianteiro Direito SKF',             3.0,   85.00, 174.00),
('SUS-006', 'Coxim de Amortecedor Dianteiro Sampel',     4.0,   38.00,  78.00),
-- Sistema Elétrico
('ELE-001', 'Bateria Moura 60Ah MF60PD',                  2.0,  298.00, 598.00),
('ELE-002', 'Bateria Heliar HF60BD 60Ah',                  1.0,  345.00, 688.00),
('ELE-003', 'Alternador Remanufaturado Bosch',             1.0,  580.00,1150.00),
('ELE-004', 'Motor de Partida Remanufaturado Bosch',       1.0,  490.00, 980.00),
('ELE-005', 'Lâmpada Farol H7 55W (par)',                 12.0,   18.00,  38.00),
('ELE-006', 'Lâmpada LED Farol H4 6000K (par)',            8.0,   65.00, 132.00),
-- Sistema de Arrefecimento / AC
('ARR-001', 'Mangueira Superior Radiador Gates',           4.0,   42.00,  86.00),
('ARR-002', 'Bomba d''Água Graf WPP1067',                  2.0,  145.00, 298.00),
('ARR-003', 'Termostato 87°C Wahler 4106.87D',            5.0,   38.00,  78.00),
('ARR-004', 'Gás Refrigerante R134a 900g',                10.0,   68.00, 138.00),
('ARR-005', 'Gás Refrigerante R1234yf 1kg',                5.0,  145.00, 290.00),
-- Embreagem
('EMB-001', 'Kit Embreagem LUK 623327200',                 1.0,  690.00,1380.00),
('EMB-002', 'Rolamento Embreagem INA',                     2.0,  128.00, 260.00),
-- Peças com estoque baixo (alertas)
('BAT-001', 'Bateria Moura 45Ah MF45KD',                   1.0,  198.00, 398.00),
('SEN-001', 'Sensor de Temperatura NTC Bosch',             2.0,   42.00,  85.00),
('MAP-001', 'Sensor MAP Delphi 12614970',                  1.0,  185.00, 370.00);


-- ─────────────────────────────────────────────────────────────
--  6. SERVIÇOS PADRÃO (tabela de preços)
-- ─────────────────────────────────────────────────────────────
INSERT INTO servicos_padrao (descricao, valor_padrao, valor_mao_de_obra, valor_material, tempo_estimado_min, observacoes) VALUES
('Troca de Óleo e Filtro (Mineral)',        185.00,  80.00, 105.00,  30, 'Inclui até 4L de óleo mineral 10W40 + filtro de óleo. Verificar nível após troca.'),
('Troca de Óleo e Filtro (Semi-Sintético)', 245.00,  80.00, 165.00,  35, 'Inclui até 4L de óleo semi-sintético 5W30 + filtro de óleo.'),
('Troca de Óleo e Filtro (Sintético)',      320.00,  80.00, 240.00,  40, 'Inclui até 4L de óleo full sintético 5W40 + filtro de óleo. Recomendado para motores turbo.'),
('Troca de Filtro de Ar',                    85.00,  35.00,  50.00,  20, 'Substituição do filtro de ar do motor. Inspecionar caixa e dutos de admissão.'),
('Troca de Filtro de Cabine (Ar-Cond.)',     98.00,  45.00,  53.00,  25, 'Inclui filtro de cabine e higienização básica do duto de ventilação.'),
('Troca de Pastilha de Freio Dianteira',    280.00, 160.00, 120.00,  90, 'Inclui par de pastilhas dianteiras. Verificar espessura dos discos. Sangrar freios se necessário.'),
('Troca de Pastilha de Freio Traseira',     260.00, 160.00, 100.00,  90, 'Inclui par de pastilhas traseiras. Verificar tambores e discos traseiros.'),
('Troca de Disco + Pastilha Dianteira',     680.00, 260.00, 420.00, 180, 'Kit completo dianteiro: 2 discos + 1 par de pastilhas. Sangria de freios inclusa.'),
('Troca de Correia Dentada',                550.00, 300.00, 250.00, 180, 'Inclui correia dentada + tensor. Alinhar marcações de ponto. Verificar bomba d''água.'),
('Kit Correia Dentada Completo',            880.00, 350.00, 530.00, 240, 'Correia dentada + tensor + correia auxiliar + bomba d''água. Verificar vedações.'),
('Troca de Correia Auxiliar',               185.00, 120.00,  65.00,  60, 'Inclui correia serpentina de acessórios. Verificar tensor e polias.'),
('Troca de Velas de Ignição',               220.00, 100.00, 120.00,  60, 'Inclui 4 velas NGK ou Bosch padrão. Para motores com velas iridium, consultar valor.'),
('Troca de Velas Iridium',                  380.00, 100.00, 280.00,  75, 'Inclui 4 velas de iridium de alta performance. Verificar bobinas e cabos.'),
('Alinhamento e Balanceamento',             180.00, 180.00,   0.00,  60, 'Alinhamento de direção computadorizado + balanceamento das 4 rodas.'),
('Geometria de Rodas',                      220.00, 220.00,   0.00,  90, 'Geometria completa: câmber, cáster, convergência e divergência nas 4 rodas.'),
('Higienização de Ar-Condicionado',         180.00, 120.00,  60.00,  90, 'Higienização interna do evaporador + aplicação de bactericida + limpeza de dreno.'),
('Carga de Gás R134a',                      280.00, 140.00, 140.00, 120, 'Evacuação do sistema + recarga com gás R134a virgem + óleo compressor. Verificar compressor e condensador.'),
('Carga de Gás R1234yf',                    420.00, 130.00, 290.00, 120, 'Evacuação + recarga R1234yf (veículos pós 2018). Verificar compressor e vazamentos.'),
('Diagnóstico Eletrônico Geral',            120.00, 120.00,   0.00,  30, 'Leitura de falhas com scanner OBD2. Relatório de códigos e recomendações.'),
('Troca de Fluido de Freio DOT 4',          145.00,  95.00,  50.00,  60, 'Sangria completa do sistema de freios com fluido DOT 4 novo. Verificar cilindros e mangueiras.'),
('Troca de Fluido de Arrefecimento',        195.00, 115.00,  80.00,  90, 'Flush completo do sistema de arrefecimento + fluido novo. Verificar bomba d''água, mangueiras e tampão.'),
('Revisão Completa (30.000 km)',           1200.00, 500.00, 700.00, 240, 'Óleo + filtros (ar, óleo, cabine, combustível) + velas + fluido de freio + verificação geral.'),
('Troca de Amortecedor Dianteiro (par)',    980.00, 480.00, 500.00, 300, 'Par de amortecedores dianteiros + coxins + rolamentos de embreagem. Alinhamento recomendado.'),
('Troca de Bateria',                        120.00, 120.00,   0.00,  20, 'Instalação de bateria fornecida pelo cliente. Para bateria da oficina, somar valor da peça.'),
('Polimento Técnico Completo',              380.00, 380.00,   0.00, 180, 'Polimento técnico + proteção vitrificada. Remove oxidação e riscos superficiais.'),
('Troca de Kit Embreagem',                 1480.00, 780.00, 700.00, 360, 'Disco + platô + rolamento de embreagem. Verificar volante do motor e guia.'),
('Manutenção Preventiva Básica',            285.00, 160.00, 125.00,  90, 'Óleo + filtro de ar + filtro de óleo + verificação de 20 itens. Indicado a cada 10.000 km.');


-- ─────────────────────────────────────────────────────────────
--  7. ORDENS DE SERVIÇO
--     Status: Aberta, Aprovada, Aguardando Peça, Em Serviço,
--             Encerrada, Paga
-- ─────────────────────────────────────────────────────────────
INSERT INTO ordens_servico (
    numero_os, data_emissao, data_entrega, data_garantia, situacao,
    atendente, problema_reclamado, observacoes, metodo_pagamento,
    check_pressao_gas, check_filtro_cabine, check_compressor, check_higienizacao,
    total_servicos, total_pecas, frete, valor_total,
    cliente_id, veiculo_id
) VALUES

-- OS 001: Aberta (Orçamento)
('00001', '2026-06-11 08:15:00', NULL, NULL, 'Aberta',
 'Ana Atendente', 'Carro está com barulho no freio dianteiro e pedal está mole.',
 'Cliente relatou que o barulho aumentou após chuva. Verificar pastilhas e discos.', NULL,
 NULL, NULL, NULL, NULL,
 0.00, 0.00, 0.00, 0.00, 1, 1),

-- OS 002: Aberta (Orçamento)
('00002', '2026-06-11 09:30:00', NULL, NULL, 'Aberta',
 'Ana Atendente', 'AC não está gelando, sai ar mas não refresca.',
 'Verificar carga de gás, compressor e condensador. Possível vazamento.', NULL,
 NULL, NULL, NULL, NULL,
 0.00, 0.00, 0.00, 0.00, 3, 3),

-- OS 003: Aprovada
('00003', '2026-06-10 10:00:00', NULL, NULL, 'Aprovada',
 'Lucas Admin', 'Revisão dos 30.000 km + troca de correia dentada preventiva.',
 'Cliente aprovou orçamento via WhatsApp. Aguardando peças chegarem.', NULL,
 NULL, NULL, NULL, NULL,
 0.00, 0.00, 0.00, 0.00, 2, 2),

-- OS 004: Aprovada
('00004', '2026-06-10 14:20:00', NULL, NULL, 'Aprovada',
 'Carlos Supervisor', 'Motor falhando em aceleração, possível problema nas velas.',
 'Orçamento de troca de velas iridium aprovado. Verificar bobinas após troca.', NULL,
 NULL, NULL, NULL, NULL,
 0.00, 0.00, 0.00, 0.00, 5, 5),

-- OS 005: Aguardando Peça
('00005', '2026-06-09 08:45:00', NULL, NULL, 'Aguardando Peça',
 'Pedro Mecânico', 'Suspensão batendo, amortecedor dianteiro com vazamento de óleo.',
 'Pedido de amortecedor Cofap feito. Prazo 2-3 dias úteis. Cliente notificado.', NULL,
 NULL, NULL, NULL, NULL,
 480.00, 498.00, 0.00, 978.00, 4, 4),

-- OS 006: Aguardando Peça
('00006', '2026-06-09 11:00:00', NULL, NULL, 'Aguardando Peça',
 'Luiz Técnico', 'Kit de embreagem patinando, dificuldade para engatar marcha.',
 'Aguardando kit LUK. Carro parado na oficina. Cliente usando transporte alternativo.', NULL,
 NULL, NULL, NULL, NULL,
 780.00, 700.00, 0.00, 1480.00, 7, 7),

-- OS 007: Em Serviço
('00007', '2026-06-11 07:30:00', NULL, NULL, 'Em Serviço',
 'Pedro Mecânico', 'Troca de óleo sintético + filtros + revisão preventiva completa.',
 'Revisão 50.000 km. Verificar estado da correia dentada e fluidos.', NULL,
 'Normal', 'Sujo', 'Armando', 'Necessita',
 320.00, 165.00, 0.00, 485.00, 6, 6),

-- OS 008: Em Serviço
('00008', '2026-06-11 08:00:00', NULL, NULL, 'Em Serviço',
 'Luiz Técnico', 'Diagnóstico eletrônico + substituição sensor MAP.',
 'Luz de motor acesa. Código P0105 identificado. Trocando sensor MAP.', NULL,
 NULL, NULL, NULL, NULL,
 120.00, 370.00, 0.00, 490.00, 8, 8),

-- OS 009: Em Serviço
('00009', '2026-06-11 09:00:00', NULL, NULL, 'Em Serviço',
 'Pedro Mecânico', 'Higienização de AC + carga de gás R134a completa.',
 'Saída de ar com cheiro ruim. Evaporador cheio de fungos. Compressor OK.', NULL,
 'Normal', 'Sujo', 'Armando', 'Necessita',
 460.00, 138.00, 0.00, 598.00, 10, 10),

-- OS 010: Encerrada — sem pagamento ainda
('00010', '2026-06-01 08:00:00', '2026-06-01 17:30:00', '2026-09-01', 'Encerrada',
 'Luiz Técnico', 'Troca de pastilhas dianteiras e traseiras + fluido de freio.',
 'Serviço concluído. Peças originais. Testado em pista local. Sem ruídos.', 'PIX',
 NULL, 'Bom', NULL, NULL,
 540.00, 270.00, 0.00, 810.00, 9, 9),

-- OS 011: Encerrada
('00011', '2026-05-28 09:00:00', '2026-05-28 16:00:00', '2026-08-28', 'Encerrada',
 'Pedro Mecânico', 'Troca de correia dentada preventiva + correia auxiliar.',
 'Correia original com 75.000 km. Substituição preventiva. Sem anomalias.', 'Cartão de Crédito',
 NULL, 'Bom', NULL, NULL,
 735.00, 330.00, 0.00, 1065.00, 11, 11),

-- OS 012: Paga
('00012', '2026-05-20 10:00:00', '2026-05-21 11:00:00', '2026-08-21', 'Paga',
 'Lucas Admin', 'Revisão completa 30.000 km.',
 'Revisão geral concluída. Todos os itens em ordem. Próxima revisão em 40.000 km.', 'PIX',
 'Normal', 'Bom', 'Armando', 'Feita',
 1200.00, 0.00, 0.00, 1200.00, 12, 12),

-- OS 013: Paga
('00013', '2026-05-15 08:30:00', '2026-05-15 15:00:00', '2026-08-15', 'Paga',
 'Luiz Técnico', 'Diagnóstico + troca de velas iridium.',
 'Motor falhava na faixa de 2000-3000 RPM. Velas antigas com eletrodo desgastado. Resolvido.', 'Dinheiro',
 NULL, NULL, NULL, NULL,
 500.00, 260.00, 0.00, 760.00, 13, 13),

-- OS 014: Paga
('00014', '2026-05-10 09:00:00', '2026-05-11 17:00:00', '2026-08-11', 'Paga',
 'Carlos Supervisor', 'Suspensão dianteira completa: amortecedores + bucha + pivô.',
 'Veículo com 120.000 km. Suspensão completamente desgastada. Alinhamento realizado após troca.', 'Cartão de Débito',
 NULL, NULL, NULL, NULL,
 960.00, 820.00, 0.00, 1780.00, 14, 14),

-- OS 015: Paga
('00015', '2026-05-05 14:00:00', '2026-05-06 12:00:00', '2026-08-06', 'Paga',
 'Pedro Mecânico', 'Troca de bateria + alternador + motor de partida.',
 'Veículo não ligava. Bateria sulfatada, alternador queimado. Sistema elétrico revisado.', 'Parcelado (3x)',
 NULL, NULL, NULL, NULL,
 240.00, 2738.00, 0.00, 2978.00, 15, 15),

-- OS 016: Paga
('00016', '2026-04-25 08:00:00', '2026-04-25 14:00:00', '2026-07-25', 'Paga',
 'Luiz Técnico', 'Alinhamento + balanceamento + geometria.',
 'Cliente reclamava de carro puxando para a direita. Geometria desregulada. Corrigido.', 'PIX',
 NULL, NULL, NULL, NULL,
 400.00, 0.00, 0.00, 400.00, 16, 16),

-- OS 017: Paga (mês anterior)
('00017', '2026-04-15 09:30:00', '2026-04-16 16:00:00', '2026-07-16', 'Paga',
 'Carlos Supervisor', 'Kit embreagem completo.',
 'Embreagem patinava desde 90.000 km. Kit LUK instalado. Volante retificado.', 'Dinheiro',
 NULL, NULL, NULL, NULL,
 780.00, 700.00, 0.00, 1480.00, 17, 17),

-- OS 018: Encerrada (meses anteriores — para popular gráfico)
('00018', '2026-03-10 08:00:00', '2026-03-10 14:30:00', '2026-06-10', 'Encerrada',
 'Luiz Técnico', 'Troca de óleo + filtros completos.',
 'Manutenção preventiva. Tudo em ordem.', 'PIX',
 'Normal', 'Bom', 'Armando', 'Feita',
 320.00, 220.00, 0.00, 540.00, 18, 18),

-- OS 019: Paga (para gráfico histórico)
('00019', '2026-03-18 10:00:00', '2026-03-19 11:00:00', '2026-06-19', 'Paga',
 'Pedro Mecânico', 'Disco e pastilha dianteira + fluido de freio.',
 'Disco com arranhado profundo. Substituição preventiva do par.', 'Cartão de Crédito',
 NULL, 'Sujo', NULL, NULL,
 805.00, 464.00, 0.00, 1269.00, 19, 19),

-- OS 020: Paga (para gráfico histórico)
('00020', '2026-02-20 08:00:00', '2026-02-21 15:00:00', '2026-05-21', 'Paga',
 'Luiz Técnico', 'Carga de gás R1234yf + higienização AC.',
 'AC sem função. Vazamento na mangueira alta pressão. Reparada e recarregada.', 'PIX',
 'Normal', 'Sujo', 'Armando', 'Feita',
 600.00, 290.00, 80.00, 970.00, 20, 20),

-- OS 021: Paga (para gráfico histórico)
('00021', '2026-02-05 09:00:00', '2026-02-05 17:00:00', '2026-05-05', 'Paga',
 'Carlos Supervisor', 'Revisão preventiva + troca de velas.',
 'Revisão geral. Motor OK. Velas com vida útil esgotada.', 'Dinheiro',
 'Normal', 'Bom', 'Armando', 'Feita',
 540.00, 180.00, 0.00, 720.00, 21, 21),

-- OS 022: Paga (para gráfico histórico)
('00022', '2026-01-10 10:00:00', '2026-01-11 14:00:00', '2026-04-11', 'Paga',
 'Luiz Técnico', 'Correia dentada + polimento externo.',
 'Correia dentada preventiva aos 60.000 km. Polimento extra solicitado pelo cliente.', 'Parcelado (2x)',
 NULL, NULL, NULL, NULL,
 930.00, 260.00, 0.00, 1190.00, 22, 22),

-- OS 023: Paga (para gráfico histórico — mês 5)
('00023', '2026-05-22 08:00:00', '2026-05-23 16:00:00', '2026-08-23', 'Paga',
 'Pedro Mecânico', 'Troca de amortecedores traseiros + alinhamento.',
 'Veículo com bounce excessivo. Amortecedores Monroe instalados. Alinhamento OK.', 'PIX',
 NULL, NULL, NULL, NULL,
 660.00, 810.00, 0.00, 1470.00, 23, 23),

-- OS 024: Encerrada (mês 5)
('00024', '2026-05-12 09:00:00', '2026-05-12 13:00:00', '2026-08-12', 'Encerrada',
 'Lucas Admin', 'Manutenção preventiva básica 10.000 km.',
 'Verificados 20 itens. Motor, freios e sistema AC em bom estado.', 'PIX',
 'Normal', 'Bom', 'Armando', 'Feita',
 285.00, 170.00, 0.00, 455.00, 24, 24),

-- OS 025: Paga (mês 6 corrente — para faturamento mensal)
('00025', '2026-06-03 08:00:00', '2026-06-03 15:00:00', '2026-09-03', 'Paga',
 'Luiz Técnico', 'Diagnóstico eletrônico + troca sensor temperatura.',
 'Check engine aceso. Sensor NTC com falha. Substituído e teste OK.', 'PIX',
 NULL, NULL, NULL, NULL,
 165.00, 85.00, 0.00, 250.00, 25, 25),

-- OS 026: Encerrada (mês 6 corrente)
('00026', '2026-06-05 10:00:00', '2026-06-05 17:30:00', '2026-09-05', 'Encerrada',
 'Pedro Mecânico', 'Troca de fluido de arrefecimento + termostato.',
 'Motor superaquecendo. Termostato preso. Flush completo realizado.', 'Cartão de Crédito',
 NULL, NULL, NULL, NULL,
 310.00, 116.00, 0.00, 426.00, 26, 26),

-- OS 027: Paga (mês 6 corrente)
('00027', '2026-06-06 08:30:00', '2026-06-07 12:00:00', '2026-09-07', 'Paga',
 'Carlos Supervisor', 'Kit correia dentada completo + bomba d''água.',
 'Correia trocada aos 90.000 km. Bomba com leakage detectada. Tudo substituído.', 'Parcelado (3x)',
 NULL, NULL, NULL, NULL,
 1230.00, 446.00, 0.00, 1676.00, 27, 27),

-- OS 028: Encerrada (mês 6 corrente)
('00028', '2026-06-08 09:00:00', '2026-06-08 16:00:00', '2026-09-08', 'Encerrada',
 'Luiz Técnico', 'Revisão completa 30.000 km + velas iridium.',
 'Revisão 30k completa. Velas iridium instaladas. Próxima revisão 60.000 km.', 'PIX',
 'Normal', 'Bom', 'Armando', 'Feita',
 1580.00, 280.00, 0.00, 1860.00, 28, 28),

-- OS 029: Paga (mês 6 corrente)
('00029', '2026-06-09 14:00:00', '2026-06-10 11:00:00', '2026-09-10', 'Paga',
 'Pedro Mecânico', 'Alinhamento + balanceamento + troca pneu avariado.',
 'Pneu dianteiro direito com bolha. Alinhamento após substituição.', 'Dinheiro',
 NULL, NULL, NULL, NULL,
 180.00, 0.00, 0.00, 180.00, 29, 29),

-- OS 030: Encerrada (mês 6 corrente)
('00030', '2026-06-10 08:00:00', '2026-06-10 14:00:00', '2026-09-10', 'Encerrada',
 'Lucas Admin', 'Higienização de AC + carga gás R134a.',
 'AC voltou a funcionar normalmente. Gás R134a recarregado. Compressor OK.', 'PIX',
 'Baixa', 'Sujo', 'Armando', 'Feita',
 460.00, 276.00, 0.00, 736.00, 30, 30);


-- ─────────────────────────────────────────────────────────────
--  8. ITENS DE SERVIÇO (para as OS encerradas/pagas/em serviço)
-- ─────────────────────────────────────────────────────────────
-- OS 007 (Em Serviço)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-003', 'Troca de Óleo e Filtro (Sintético)',      1.0, 'Sv', 320.00, 320.00, 'PEDRO MECÂNICO', 7);

-- OS 008 (Em Serviço)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-019', 'Diagnóstico Eletrônico Geral',            1.0, 'Sv', 120.00, 120.00, 'LUIZ TÉCNICO',   8);

-- OS 009 (Em Serviço)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-016', 'Higienização de Ar-Condicionado',         1.0, 'Sv', 180.00, 180.00, 'PEDRO MECÂNICO', 9),
('SVC-017', 'Carga de Gás R134a',                      1.0, 'Sv', 280.00, 280.00, 'PEDRO MECÂNICO', 9);

-- OS 010 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-006', 'Troca de Pastilha de Freio Dianteira',    1.0, 'Sv', 280.00, 280.00, 'LUIZ TÉCNICO',   10),
('SVC-007', 'Troca de Pastilha de Freio Traseira',     1.0, 'Sv', 260.00, 260.00, 'LUIZ TÉCNICO',   10);

-- OS 011 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-009', 'Troca de Correia Dentada',                1.0, 'Sv', 550.00, 550.00, 'PEDRO MECÂNICO', 11),
('SVC-011', 'Troca de Correia Auxiliar',               1.0, 'Sv', 185.00, 185.00, 'PEDRO MECÂNICO', 11);

-- OS 012 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-022', 'Revisão Completa (30.000 km)',            1.0, 'Sv', 1200.00, 1200.00, 'LUIZ TÉCNICO', 12);

-- OS 013 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-019', 'Diagnóstico Eletrônico Geral',            1.0, 'Sv', 120.00, 120.00, 'CARLOS SUPERVISOR', 13),
('SVC-013', 'Troca de Velas Iridium',                  1.0, 'Sv', 380.00, 380.00, 'CARLOS SUPERVISOR', 13);

-- OS 014 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-023', 'Troca de Amortecedor Dianteiro (par)',    1.0, 'Sv', 480.00, 480.00, 'LUIZ TÉCNICO',      14),
('SVC-015', 'Geometria de Rodas',                      1.0, 'Sv', 220.00, 220.00, 'LUIZ TÉCNICO',      14),
('SVC-014', 'Alinhamento e Balanceamento',             1.0, 'Sv', 180.00, 180.00, 'LUIZ TÉCNICO',      14),
('SVC-006', 'Troca de Pastilha de Freio Dianteira',    1.0, 'Sv',  80.00,  80.00, 'LUIZ TÉCNICO',      14);

-- OS 015 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-024', 'Troca de Bateria',                        1.0, 'Sv', 120.00, 120.00, 'PEDRO MECÂNICO',    15),
('ELE-WORK', 'Reparo Alternador + Partida (M.O.)',      3.0, 'Hs', 40.00,  120.00, 'PEDRO MECÂNICO',   15);

-- OS 016 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-014', 'Alinhamento e Balanceamento',             1.0, 'Sv', 180.00, 180.00, 'LUIZ TÉCNICO',      16),
('SVC-015', 'Geometria de Rodas',                      1.0, 'Sv', 220.00, 220.00, 'LUIZ TÉCNICO',      16);

-- OS 017 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-026', 'Troca de Kit Embreagem',                  1.0, 'Sv', 780.00, 780.00, 'CARLOS SUPERVISOR', 17);

-- OS 018 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-003', 'Troca de Óleo e Filtro (Sintético)',      1.0, 'Sv', 320.00, 320.00, 'LUIZ TÉCNICO',      18);

-- OS 019 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-008', 'Troca de Disco + Pastilha Dianteira',     1.0, 'Sv', 680.00, 680.00, 'PEDRO MECÂNICO',    19),
('SVC-020', 'Troca de Fluido de Freio DOT 4',          1.0, 'Sv', 145.00, 125.00, 'PEDRO MECÂNICO',    19);

-- OS 020 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-018', 'Carga de Gás R1234yf',                    1.0, 'Sv', 420.00, 420.00, 'LUIZ TÉCNICO',      20),
('SVC-016', 'Higienização de Ar-Condicionado',         1.0, 'Sv', 180.00, 180.00, 'LUIZ TÉCNICO',      20);

-- OS 021 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-027', 'Manutenção Preventiva Básica',            1.0, 'Sv', 285.00, 285.00, 'CARLOS SUPERVISOR', 21),
('SVC-012', 'Troca de Velas de Ignição',               1.0, 'Sv', 220.00, 220.00, 'CARLOS SUPERVISOR', 21),
('SVC-019', 'Diagnóstico Eletrônico Geral',            1.0, 'Sv', 120.00,  35.00, 'CARLOS SUPERVISOR', 21);

-- OS 022 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-009', 'Troca de Correia Dentada',                1.0, 'Sv', 550.00, 550.00, 'PEDRO MECÂNICO',    22),
('SVC-025', 'Polimento Técnico Completo',              1.0, 'Sv', 380.00, 380.00, 'PEDRO MECÂNICO',    22);

-- OS 023 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SUS-WORK', 'Troca Amortecedor Traseiro Par + Coxins', 1.0, 'Sv', 480.00, 480.00, 'LUIZ TÉCNICO',    23),
('SVC-014', 'Alinhamento e Balanceamento',             1.0, 'Sv', 180.00, 180.00, 'LUIZ TÉCNICO',      23);

-- OS 024 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-027', 'Manutenção Preventiva Básica',            1.0, 'Sv', 285.00, 285.00, 'LUCAS ADMIN',       24);

-- OS 025 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-019', 'Diagnóstico Eletrônico Geral',            1.0, 'Sv', 120.00, 120.00, 'LUIZ TÉCNICO',      25),
('SEN-WORK', 'Troca Sensor Temperatura (M.O.)',         1.0, 'Sv',  45.00,  45.00, 'LUIZ TÉCNICO',      25);

-- OS 026 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-021', 'Troca de Fluido de Arrefecimento',        1.0, 'Sv', 195.00, 195.00, 'PEDRO MECÂNICO',    26),
('TER-WORK', 'Troca de Termostato (M.O.)',              1.0, 'Sv', 115.00, 115.00, 'PEDRO MECÂNICO',    26);

-- OS 027 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-010', 'Kit Correia Dentada Completo',            1.0, 'Sv', 880.00, 880.00, 'CARLOS SUPERVISOR', 27),
('BMB-WORK', 'Troca Bomba d''Água (M.O. adicional)',   1.0, 'Sv', 350.00, 350.00, 'CARLOS SUPERVISOR', 27);

-- OS 028 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-022', 'Revisão Completa (30.000 km)',            1.0, 'Sv', 1200.00, 1200.00, 'LUIZ TÉCNICO',    28),
('SVC-013', 'Troca de Velas Iridium',                  1.0, 'Sv',  380.00,  380.00, 'LUIZ TÉCNICO',    28);

-- OS 029 (Paga)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-014', 'Alinhamento e Balanceamento',             1.0, 'Sv', 180.00, 180.00, 'PEDRO MECÂNICO',    29);

-- OS 030 (Encerrada)
INSERT INTO itens_servico (codigo_servico, descricao, quantidade, unidade, valor_unitario, valor_total, tecnico, ordem_servico_id) VALUES
('SVC-016', 'Higienização de Ar-Condicionado',         1.0, 'Sv', 180.00, 180.00, 'LUCAS ADMIN',       30),
('SVC-017', 'Carga de Gás R134a',                      1.0, 'Sv', 280.00, 280.00, 'LUCAS ADMIN',       30);


-- ─────────────────────────────────────────────────────────────
--  9. ITENS DE PEÇA (ligados ao estoque via peca_estoque_id)
-- ─────────────────────────────────────────────────────────────
-- Referências dos IDs de peças (baseado na ordem de inserção acima):
-- FIL-001=1, FIL-002=2, FIL-003=3, FIL-004=4, FIL-005=5
-- OLE-001=6, OLE-002=7, OLE-003=8, OLE-004=9, OLE-005=10, OLE-006=11
-- FRE-001=12, FRE-002=13, FRE-003=14, FRE-004=15, FRE-005=16
-- COR-001=17, COR-002=18, COR-003=19, COR-004=20
-- VEL-001=21, VEL-002=22, VEL-003=23, VEL-004=24
-- SUS-001=25, SUS-002=26, SUS-003=27, SUS-004=28, SUS-005=29, SUS-006=30
-- ELE-001=31, ELE-002=32, ELE-003=33, ELE-004=34, ELE-005=35, ELE-006=36
-- ARR-001=37, ARR-002=38, ARR-003=39, ARR-004=40, ARR-005=41
-- EMB-001=42, EMB-002=43
-- BAT-001=44, SEN-001=45, MAP-001=46

-- OS 007 (Em Serviço) — óleo sintético + filtro
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('OLE-002', 'Óleo Motor Castrol 5W40 Full Sintético 1L', 4.0, 62.00, 248.00, 7, 7),
('FIL-001', 'Filtro de Óleo Bosch F026407123',           1.0, 38.00,  38.00, 7, 1),
('FIL-002', 'Filtro de Ar Mann C25117',                  1.0, 45.00,  45.00, 7, 2),
('FIL-003', 'Filtro de Cabine Mahle LA258',              1.0, 52.00,  52.00, 7, 3);

-- OS 008 (Em Serviço) — sensor MAP
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('MAP-001', 'Sensor MAP Delphi 12614970',                1.0, 370.00, 370.00, 8, 46);

-- OS 009 (Em Serviço) — gás R134a
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('ARR-004', 'Gás Refrigerante R134a 900g',               1.0, 138.00, 138.00, 9, 40);

-- OS 010 (Encerrada) — pastilhas + fluido
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('FRE-001', 'Pastilha de Freio Dianteira Fremax BD5108', 1.0, 120.00, 120.00, 10, 12),
('FRE-002', 'Pastilha de Freio Traseira Fremax BD5112',  1.0, 108.00, 108.00, 10, 13),
('OLE-004', 'Fluido de Freio DOT 4 Bosch 500ml',         1.0,  48.00,  48.00, 10, 9);

-- OS 011 (Encerrada) — correia + tensor + correia aux
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('COR-001', 'Correia Dentada Gates PowerGrip K075355',   1.0, 168.00, 168.00, 11, 17),
('COR-004', 'Tensor Correia Dentada INA',                1.0, 160.00, 160.00, 11, 20),
('COR-003', 'Correia Alternador/Acessórios Gates',       1.0,  92.00,  92.00, 11, 19);

-- OS 014 (Paga) — amortecedores + bucha + pivô + pastilha
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('SUS-001', 'Amortecedor Dianteiro Cofap Kayaba',        2.0, 498.00, 498.00, 14, 25),
('SUS-004', 'Bucha Bandeja Dianteira Febest',            4.0,  49.00, 196.00, 14, 28),
('SUS-005', 'Kit Pivô Dianteiro Direito SKF',            1.0, 174.00, 174.00, 14, 29),
('FRE-001', 'Pastilha de Freio Dianteira Fremax',        1.0, 120.00, 120.00, 14, 12),
('SUS-006', 'Coxim de Amortecedor Dianteiro Sampel',     2.0,  78.00, 156.00, 14, 30);

-- OS 015 (Paga) — bateria + alternador + partida
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('ELE-001', 'Bateria Moura 60Ah MF60PD',                 1.0, 598.00, 598.00, 15, 31),
('ELE-003', 'Alternador Remanufaturado Bosch',            1.0,1150.00,1150.00, 15, 33),
('ELE-004', 'Motor de Partida Remanufaturado Bosch',      1.0, 980.00, 980.00, 15, 34);

-- OS 017 (Paga) — kit embreagem
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('EMB-001', 'Kit Embreagem LUK 623327200',               1.0,1380.00,1380.00, 17, 42),
('EMB-002', 'Rolamento Embreagem INA',                   1.0, 260.00, 260.00, 17, 43);

-- OS 018 (Encerrada) — óleo semi + filtros
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('OLE-002', 'Óleo Motor Castrol 5W40 Full Sintético 1L', 4.0, 62.00, 248.00, 18, 7),
('FIL-001', 'Filtro de Óleo Bosch F026407123',           1.0, 38.00,  38.00, 18, 1);

-- OS 019 (Paga) — disco + pastilha + fluido
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('FRE-003', 'Disco de Freio Dianteiro Hipper Freios',    2.0, 298.00, 298.00, 19, 14),
('FRE-001', 'Pastilha de Freio Dianteira Fremax BD5108', 1.0, 120.00, 120.00, 19, 12),
('OLE-004', 'Fluido de Freio DOT 4 Bosch 500ml',         1.0,  48.00,  48.00, 19, 9);

-- OS 020 (Paga) — gás R1234yf
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('ARR-005', 'Gás Refrigerante R1234yf 1kg',              1.0, 290.00, 290.00, 20, 41);

-- OS 021 (Paga) — óleo + filtro + velas
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('OLE-001', 'Óleo Motor Mobil 5W30 Sintético 1L',        4.0, 55.00, 220.00, 21, 6),
('FIL-001', 'Filtro de Óleo Bosch F026407123',           1.0, 38.00,  38.00, 21, 1),
('VEL-001', 'Vela de Ignição NGK BKR5EK (unitária)',     4.0, 29.00, 116.00, 21, 21);

-- OS 022 (Paga) — correia + tensor
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('COR-001', 'Correia Dentada Gates PowerGrip K075355',   1.0, 168.00, 168.00, 22, 17),
('COR-004', 'Tensor Correia Dentada INA',                1.0, 160.00, 160.00, 22, 20);

-- OS 023 (Paga) — amortecedores traseiros
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('SUS-002', 'Amortecedor Traseiro Monroe Matic',         2.0, 405.00, 810.00, 23, 26);

-- OS 024 (Encerrada) — óleo + filtros preventiva
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('OLE-003', 'Óleo Motor Shell Helix 10W40 Semi-Sint. 1L',4.0, 44.00, 176.00, 24, 8),
('FIL-001', 'Filtro de Óleo Bosch F026407123',           1.0, 38.00,  38.00, 24, 1),
('FIL-002', 'Filtro de Ar Mann C25117',                  1.0, 45.00,  45.00, 24, 2);

-- OS 025 (Paga) — sensor temperatura
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('SEN-001', 'Sensor de Temperatura NTC Bosch',           1.0,  85.00,  85.00, 25, 45);

-- OS 026 (Encerrada) — termostato + fluido arrefecimento
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('ARR-003', 'Termostato 87°C Wahler 4106.87D',           1.0,  78.00,  78.00, 26, 39),
('OLE-005', 'Fluido de Arrefecimento Basf 1L',           2.0,  36.00,  72.00, 26, 10);

-- OS 027 (Paga) — kit correia + bomba d'água
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('COR-002', 'Kit Correia + Tensionador + Correia Aux',   1.0, 498.00, 498.00, 27, 18),
('ARR-002', 'Bomba d''Água Graf WPP1067',                1.0, 298.00, 298.00, 27, 38),
('OLE-005', 'Fluido de Arrefecimento Basf 1L',           2.0,  36.00,  72.00, 27, 10);

-- OS 028 (Encerrada) — revisão + velas iridium + filtros
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('VEL-003', 'Vela Iridium NGK ILZFR6D11 (unitária)',     4.0, 65.00, 260.00, 28, 23),
('FIL-001', 'Filtro de Óleo Bosch F026407123',           1.0, 38.00,  38.00, 28, 1),
('FIL-002', 'Filtro de Ar Mann C25117',                  1.0, 45.00,  45.00, 28, 2),
('FIL-003', 'Filtro de Cabine Mahle LA258',              1.0, 52.00,  52.00, 28, 3);

-- OS 030 (Encerrada) — gás R134a
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('ARR-004', 'Gás Refrigerante R134a 900g',               2.0, 138.00, 276.00, 30, 40);

-- OS 005 (Aguardando Peça) — amortecedor já lançado
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('SUS-001', 'Amortecedor Dianteiro Cofap Kayaba',        1.0, 498.00, 498.00, 5, 25);

-- OS 006 (Aguardando Peça) — embreagem já lançada
INSERT INTO itens_peca (codigo_peca, descricao, quantidade, valor_unitario, valor_total, ordem_servico_id, peca_estoque_id) VALUES
('EMB-001', 'Kit Embreagem LUK 623327200',               1.0, 1380.00, 1380.00, 6, 42),
('EMB-002', 'Rolamento Embreagem INA',                   1.0,  260.00,  260.00, 6, 43);


-- ─────────────────────────────────────────────────────────────
--  10. AGENDAMENTOS (próximos dias)
-- ─────────────────────────────────────────────────────────────
INSERT INTO agendamentos (nome_cliente, telefone, veiculo, servico_desejado, data_hora, status) VALUES
('João Carlos Pereira',     '(11) 99234-5678', 'VW Gol 1.0 — ABC-1234',        'Troca de pastilhas de freio + verificação suspensão',       '2026-06-12 08:00:00', 'Pendente'),
('Camila Rocha Andrade',    '(11) 98765-4320', 'Toyota Yaris XLS — HIJ-5678',  'Revisão preventiva 20.000 km + troca de óleo',              '2026-06-12 10:00:00', 'Pendente'),
('Thiago Gomes Cardoso',    '(11) 97654-3219', 'Renault Kwid Intense — KLM-9012','Diagnóstico (AC não funciona)',                            '2026-06-12 13:30:00', 'Pendente'),
('Renata Silva Monteiro',   '(11) 96543-2108', 'Kia Sportage EX — NOP-3456',   'Alinhamento + balanceamento',                               '2026-06-13 08:30:00', 'Pendente'),
('Diego Nascimento Lopes',  '(11) 95432-1097', 'Fiat Pulse Drive — QRS-7890',  'Troca de velas + diagnóstico eletrônico',                   '2026-06-13 10:00:00', 'Pendente'),
('Vanessa Ribeiro Cruz',    '(11) 94321-0986', 'Chevrolet Cruze HB — TUV-1234','Troca de óleo sintético + filtros',                         '2026-06-13 14:00:00', 'Pendente'),
('Eduardo Araujo Dias',     '(11) 93210-9875', 'Honda HRV EX — WXY-5678',      'Revisão de freios + geometria',                             '2026-06-14 08:00:00', 'Pendente'),
('Mariana Lima Vaz',        '(11) 92109-8764', 'Volkswagen Polo GTS — ZAB-9012','Higienização de AC + carga de gás R134a',                  '2026-06-14 10:30:00', 'Pendente'),
('Bruno Freitas Teixeira',  '(11) 91098-7653', 'Toyota RAV4 Adventure — CDE-3456','Troca de correia dentada preventiva',                    '2026-06-14 13:00:00', 'Pendente'),
('Larissa Borges Pires',    '(11) 90987-6542', 'Ford Ranger XLS — FGH-7890',   'Manutenção preventiva + troca de fluidos',                  '2026-06-16 08:00:00', 'Pendente'),
('Gustavo Moraes Cunha',    '(21) 99234-1234', 'Fiat Fastback Turbo — IJK-1234','Diagnóstico + troca correia auxiliar',                     '2026-06-16 10:00:00', 'Pendente'),
('Rafael Pereira Gomes',    '(21) 97654-3456', 'Hyundai HB20 Diamond — OPQ-9012','Troca de pastilhas traseiras + fluido freio',             '2026-06-17 09:00:00', 'Pendente'),
('Simone Campos Brandão',   '(31) 99234-6789', 'Volkswagen Virtus — XYZ-1234', 'Revisão 30.000 km completa',                                '2026-06-17 08:00:00', 'Pendente'),
('Ana Beatriz Rodrigues',   '(11) 94321-0987', 'Toyota Corolla XEi — GHI-9012','Polimento técnico completo',                                '2026-06-18 09:00:00', 'Pendente'),
('Carlos Eduardo Martins',  '(11) 95432-1098', 'Chevrolet Onix Plus — MNO-7890','Troca de bateria (cliente traz peça)',                     '2026-06-11 11:00:00', 'Chegou'),
('Maria Fernanda Santos',   '(11) 98765-4321', 'Honda Civic EX — DEF-5678',    'Verificação geral + check engine',                          '2026-06-11 09:00:00', 'Chegou'),
('Patrícia Lima Costa',     '(11) 96543-2109', 'Hyundai Creta Smart — JKL-3456','Troca amortecedor dianteiro direito',                      '2026-06-11 10:00:00', 'Chegou'),
('Rodrigo Vieira Matos',    '(41) 98765-9012', 'Jeep Renegade Sport — LMN-5678','Alinhamento completo + geometria',                         '2026-06-19 14:00:00', 'Cancelado');


-- ─────────────────────────────────────────────────────────────
--  11. TRANSAÇÕES DE CAIXA (histórico financeiro)
-- ─────────────────────────────────────────────────────────────
INSERT INTO transacoes_caixa (descricao, tipo, valor, data_registro, status, data_vencimento, data_pagamento, categoria, forma_pagamento) VALUES
-- Receitas (entradas) — OS pagas e outros
('OS #00012 - Revisão 30.000 km - Camila Rocha',          'ENTRADA', 1200.00, '2026-05-21 11:30:00', 'PAGO', '2026-05-21', '2026-05-21', 'Serviços',     'PIX'),
('OS #00013 - Velas Iridium - Thiago Gomes',              'ENTRADA',  760.00, '2026-05-15 15:30:00', 'PAGO', '2026-05-15', '2026-05-15', 'Serviços',     'Dinheiro'),
('OS #00014 - Suspensão Completa - Renata Monteiro',      'ENTRADA', 1780.00, '2026-05-11 17:30:00', 'PAGO', '2026-05-11', '2026-05-11', 'Serviços',     'Cartão de Débito'),
('OS #00015 - Sistema Elétrico - Diego Lopes',            'ENTRADA', 2978.00, '2026-05-06 12:30:00', 'PAGO', '2026-05-06', '2026-05-06', 'Serviços',     'Parcelado'),
('OS #00016 - Alinhamento e Geometria - Vanessa Cruz',    'ENTRADA',  400.00, '2026-04-25 14:30:00', 'PAGO', '2026-04-25', '2026-04-25', 'Serviços',     'PIX'),
('OS #00017 - Kit Embreagem - Eduardo Dias',              'ENTRADA', 1480.00, '2026-04-16 16:30:00', 'PAGO', '2026-04-16', '2026-04-16', 'Serviços',     'Dinheiro'),
('OS #00019 - Freios Completo - Toyota RAV4',             'ENTRADA', 1269.00, '2026-03-19 11:30:00', 'PAGO', '2026-03-19', '2026-03-19', 'Serviços',     'Cartão de Crédito'),
('OS #00020 - Gás AC R1234yf - Ford Ranger',              'ENTRADA',  970.00, '2026-02-21 15:30:00', 'PAGO', '2026-02-21', '2026-02-21', 'Serviços',     'PIX'),
('OS #00021 - Manutenção Preventiva - Fiat Fastback',     'ENTRADA',  720.00, '2026-02-05 17:30:00', 'PAGO', '2026-02-05', '2026-02-05', 'Serviços',     'Dinheiro'),
('OS #00022 - Correia + Polimento - Jeep Compass',        'ENTRADA', 1190.00, '2026-01-11 14:30:00', 'PAGO', '2026-01-11', '2026-01-11', 'Serviços',     'Parcelado'),
('OS #00023 - Amortecedores Traseiros - Nissan Sentra',   'ENTRADA', 1470.00, '2026-05-23 16:30:00', 'PAGO', '2026-05-23', '2026-05-23', 'Serviços',     'PIX'),
('OS #00025 - Sensor MAP + Diagnóstico',                  'ENTRADA',  250.00, '2026-06-03 15:30:00', 'PAGO', '2026-06-03', '2026-06-03', 'Serviços',     'PIX'),
('OS #00027 - Kit Correia + Bomba d''Água',               'ENTRADA', 1676.00, '2026-06-07 12:30:00', 'PAGO', '2026-06-07', '2026-06-07', 'Serviços',     'Parcelado'),
('OS #00029 - Alinhamento e Balanceamento',               'ENTRADA',  180.00, '2026-06-10 11:30:00', 'PAGO', '2026-06-10', '2026-06-10', 'Serviços',     'Dinheiro'),
-- Receitas pendentes (a receber)
('OS #00010 - Pastilhas + Fluido - S10 High Country',     'ENTRADA',  810.00, '2026-06-01 18:00:00', 'PENDENTE', '2026-06-15', NULL, 'Serviços',     NULL),
('OS #00011 - Correia Dentada - VW T-Cross',              'ENTRADA', 1065.00, '2026-05-28 17:00:00', 'PENDENTE', '2026-06-12', NULL, 'Serviços',     NULL),
-- Despesas (saídas)
('Compra de Óleo Motor - Lote 20L Castrol',               'SAIDA',    640.00, '2026-06-01 10:00:00', 'PAGO', '2026-06-01', '2026-06-01', 'Fornecedores', 'PIX'),
('Compra de Filtros - Lote Bosch/Mann',                   'SAIDA',    380.00, '2026-06-02 10:00:00', 'PAGO', '2026-06-02', '2026-06-02', 'Fornecedores', 'Boleto'),
('Aluguel da Oficina - Junho/2026',                       'SAIDA',   3500.00, '2026-06-01 09:00:00', 'PAGO', '2026-06-05', '2026-06-04', 'Aluguel',      'Transferência'),
('Energia Elétrica - Maio/2026',                          'SAIDA',    780.00, '2026-06-10 08:00:00', 'PAGO', '2026-06-10', '2026-06-10', 'Água/Luz',     'Débito Automático'),
('Água - Maio/2026',                                      'SAIDA',    145.00, '2026-06-10 08:00:00', 'PAGO', '2026-06-10', '2026-06-10', 'Água/Luz',     'Débito Automático'),
('Salário Luiz Técnico - Maio/2026',                      'SAIDA',   3200.00, '2026-06-05 08:00:00', 'PAGO', '2026-06-05', '2026-06-05', 'Salários',     'Transferência'),
('Salário Pedro Mecânico - Maio/2026',                    'SAIDA',   2800.00, '2026-06-05 08:00:00', 'PAGO', '2026-06-05', '2026-06-05', 'Salários',     'Transferência'),
('Salário Ana Atendente - Maio/2026',                     'SAIDA',   1900.00, '2026-06-05 08:00:00', 'PAGO', '2026-06-05', '2026-06-05', 'Salários',     'Transferência'),
('Compra de Peças - Fremax Pastilhas Lote',               'SAIDA',    920.00, '2026-05-28 10:00:00', 'PAGO', '2026-05-28', '2026-05-28', 'Fornecedores', 'PIX'),
('Compra Gás Refrigerante - ARFluid Distribuidora',       'SAIDA',   1240.00, '2026-05-20 10:00:00', 'PAGO', '2026-05-20', '2026-05-20', 'Fornecedores', 'Boleto'),
('Impostos MEI/CNPJ - Maio/2026',                         'SAIDA',    890.00, '2026-06-20 09:00:00', 'PENDENTE', '2026-06-20', NULL, 'Impostos',     NULL),
('Telefone e Internet - Junho/2026',                      'SAIDA',    180.00, '2026-06-10 08:00:00', 'PAGO', '2026-06-10', '2026-06-10', 'Outros',       'Débito Automático'),
('Material de Limpeza e EPI',                             'SAIDA',    320.00, '2026-06-08 10:00:00', 'PAGO', '2026-06-08', '2026-06-08', 'Outros',       'Dinheiro'),
('Compra Scanner OBD2 Profissional Launch X431',          'SAIDA',   4200.00, '2026-04-15 10:00:00', 'PAGO', '2026-04-15', '2026-04-15', 'Equipamentos', 'Parcelado'),
('Manutenção Compressor de Ar',                           'SAIDA',    680.00, '2026-03-10 10:00:00', 'PAGO', '2026-03-10', '2026-03-10', 'Manutenção',   'PIX'),
('Aluguel da Oficina - Maio/2026',                        'SAIDA',   3500.00, '2026-05-01 09:00:00', 'PAGO', '2026-05-05', '2026-05-04', 'Aluguel',      'Transferência'),
('Energia Elétrica - Abril/2026',                         'SAIDA',    820.00, '2026-05-10 08:00:00', 'PAGO', '2026-05-10', '2026-05-10', 'Água/Luz',     'Débito Automático'),
('Salários Equipe - Abril/2026',                          'SAIDA',   7900.00, '2026-05-05 08:00:00', 'PAGO', '2026-05-05', '2026-05-05', 'Salários',     'Transferência'),
('Compra Peças Suspensão - Cofap/Monroe Lote',            'SAIDA',   2890.00, '2026-05-15 10:00:00', 'PAGO', '2026-05-15', '2026-05-15', 'Fornecedores', 'Boleto'),
('Seguro Oficina - Anual',                                'SAIDA',   1800.00, '2026-01-10 09:00:00', 'PAGO', '2026-01-15', '2026-01-14', 'Outros',       'Boleto'),
('Salários Equipe - Junho/2026',                          'SAIDA',   7900.00, '2026-06-30 08:00:00', 'PENDENTE', '2026-06-30', NULL, 'Salários', NULL);


-- ─────────────────────────────────────────────────────────────
--  12. VERIFICAÇÃO FINAL
-- ─────────────────────────────────────────────────────────────
SELECT 'Clientes'          AS tabela, COUNT(*) AS registros FROM clientes
UNION ALL
SELECT 'Veículos',           COUNT(*) FROM veiculos
UNION ALL
SELECT 'Usuários',           COUNT(*) FROM usuarios
UNION ALL
SELECT 'Peças (Estoque)',     COUNT(*) FROM pecas
UNION ALL
SELECT 'Serviços Padrão',    COUNT(*) FROM servicos_padrao
UNION ALL
SELECT 'Ordens de Serviço',  COUNT(*) FROM ordens_servico
UNION ALL
SELECT 'Itens de Serviço',   COUNT(*) FROM itens_servico
UNION ALL
SELECT 'Itens de Peça',      COUNT(*) FROM itens_peca
UNION ALL
SELECT 'Agendamentos',        COUNT(*) FROM agendamentos
UNION ALL
SELECT 'Transações de Caixa', COUNT(*) FROM transacoes_caixa;

-- Faturamento do mês corrente (Junho/2026)
SELECT 
    'Faturamento Junho/2026' AS metrica,
    COALESCE(SUM(valor_total), 0) AS valor
FROM ordens_servico 
WHERE (situacao = 'Encerrada' OR situacao = 'Paga') 
  AND data_entrega >= '2026-06-01 00:00:00' 
  AND data_entrega <= '2026-06-30 23:59:59';

-- Distribuição de status das OS
SELECT situacao, COUNT(*) AS quantidade FROM ordens_servico GROUP BY situacao ORDER BY quantidade DESC;
