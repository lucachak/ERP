# 🚗 Cambiomatic — ERP para Oficinas Mecânicas

> Sistema ERP web completo para a gestão eficiente de oficinas mecânicas, construído com Java & Spring Boot.

[![Live Demo](https://img.shields.io/badge/🌐_Live_Demo-Cambiomatic-0ea5e9?style=for-the-badge)](https://cambiomatic.onrender.com/)
[![Java](https://img.shields.io/badge/Java-21-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Spring Boot](https://img.shields.io/badge/Spring_Boot-4.0-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Neon-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://neon.tech/)
[![Docker](https://img.shields.io/badge/Docker-Pronto-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

---

## 📋 Visão Geral

O **Cambiomatic** é uma aplicação web ERP (Enterprise Resource Planning) focada em resolver os desafios do dia a dia de uma oficina mecânica especializada em **ar condicionado veicular**. Sem depender de IA ou soluções mirabolantes — o sistema entrega o que realmente importa: **velocidade, estabilidade e controle prático** sobre ordens de serviço, clientes, estoque e fluxo financeiro.

---

## ✨ Funcionalidades

### 📄 Ordens de Serviço (OS)
- Criação de OS com cadastro simultâneo de cliente e veículo (novo ou existente)
- Identificador único gerado automaticamente por UUID
- Adição de **serviços** e **peças** a uma OS em aberto
- Cálculo automático de totais (serviços + peças + frete)
- Checklist técnico integrado (pressão de gás, filtro de cabine, compressor, higienização)
- Fechamento de OS com data de entrega e **garantia de 90 dias** automática
- Impressão de OS formatada para o cliente
- Pesquisa paginada por número, cliente, placa, etc.

### 🗂️ Kanban de OS
- Visualização das OS em quadro Kanban com 4 colunas de status:
  - **Aberta** → **Aguardando Peça** → **Em Serviço** → **Encerrada**
- Atualização de situação com drag-and-drop (via HTMX, sem reload)
- Filtro por termo diretamente no quadro

### 👥 Clientes & Veículos
- Cadastro completo de clientes (nome, CPF/CNPJ, RG/IE, endereço, contatos)
- Histórico de veículos por cliente (modelo, placa/chassi, ano, prisma)
- Busca e filtro com listagem paginada

### 🔧 Serviços Padrão
- Tabela de serviços pré-cadastrados com valor padrão
- Reutilizáveis na criação de itens de OS (com possibilidade de sobrescrever o valor)

### 📦 Estoque (Peças)
- Cadastro de peças com código, descrição, quantidade e preço de venda
- Baixa automática de estoque ao adicionar uma peça a uma OS
- Estorno automático de estoque ao remover uma peça da OS
- **Alerta de estoque crítico** no Dashboard (quantidade ≤ 2 unidades)

### 💰 Caixa (Financeiro)
- Registro de entradas e saídas financeiras
- Filtro por mês/ano
- Cálculo de saldo: `Entradas − Saídas`
- Campos extras: status (PENDENTE/PAGO), data de vencimento, data de pagamento, categoria, forma de pagamento
- **Baixa de contas** pendentes com um clique
- **Exportação para CSV** (compatível com Excel, com BOM UTF-8 para acentos)

### 📊 Dashboard (Painel Administrativo)
- KPIs do mês atual: faturamento, OS abertas, alertas de estoque, tempo médio de serviço
- **Gráfico de Rosca** — distribuição das OS por status
- **Gráfico de Barras** — faturamento dos últimos 6 meses
- Tabela das 5 últimas OS emitidas

### 📅 Agenda
- Registro e listagem de agendamentos

### 📈 Relatório de Comissões
- Agrupamento de serviços realizados por técnico no mês selecionado
- Cálculo de total de horas e valor total por técnico

### 👤 Gestão de Usuários
- Criação de usuários com dois perfis: **ADMIN** e **Mecânico**
- Perfil de usuário com alteração de senha
- Criação rápida de usuário via modal (resposta parcial via HTMX)

### 🔐 Segurança
| Recurso | ADMIN | Mecânico |
|---|---|---|
| Dashboard, Caixa, Relatórios | ✅ | ❌ |
| Usuários, Backup, Agenda, Kanban | ✅ | ❌ |
| Ordens de Serviço (listagem/detalhes) | ✅ | ✅ |
| Clientes, Estoque, Serviços Padrão | ✅ | ✅ |

### 💾 Backup
- Geração de backup do banco de dados via `pg_dump` a partir da própria interface web
- Download do arquivo `.sql` diretamente pelo browser

---

## 🛠️ Stack Tecnológica

| Camada | Tecnologia |
|---|---|
| **Linguagem** | Java 21 |
| **Framework** | Spring Boot 4.0 |
| **Segurança** | Spring Security (BCrypt + Form Login) |
| **Persistência** | Spring Data JPA + Hibernate |
| **Migrações DB** | Flyway |
| **Banco de Dados** | PostgreSQL (Neon Serverless) |
| **Templates** | Thymeleaf + Thymeleaf Security Extras |
| **Interatividade** | HTMX (atualizações parciais sem JavaScript complexo) |
| **Redução de boilerplate** | Lombok |
| **Validação** | Jakarta Bean Validation |
| **Containerização** | Docker (multi-stage build) |
| **Hospedagem** | Render (cloud) |

---

## 🗂️ Estrutura do Projeto

```
src/main/
├── java/erp/vivian/
│   ├── VivianApplication.java       # Ponto de entrada da aplicação
│   ├── config/
│   │   ├── SecurityConfig.java      # Regras de autenticação e autorização
│   │   └── SetupInicial.java        # Cria o usuário admin padrão na 1ª execução
│   ├── controller/                  # Camada de apresentação (MVC)
│   │   ├── OrdemServicoController.java
│   │   ├── DashboardController.java
│   │   ├── CaixaController.java
│   │   ├── ClienteController.java
│   │   ├── EstoqueController.java
│   │   ├── AgendamentoController.java
│   │   ├── RelatorioController.java
│   │   ├── ServicoPadraoController.java
│   │   ├── UsuarioController.java
│   │   ├── BackupController.java
│   │   └── LoginController.java
│   ├── service/                     # Regras de negócio
│   │   ├── OrdemServicoService.java # Serviço mais complexo (cálculos, baixa de estoque)
│   │   ├── CaixaService.java
│   │   ├── ClienteService.java
│   │   ├── EstoqueService.java
│   │   ├── ServicoPadraoService.java
│   │   ├── UsuarioService.java
│   │   ├── BackupService.java       # Geração de backup via pg_dump
│   │   └── AutenticacaoService.java
│   ├── repository/                  # Interfaces Spring Data JPA
│   │   ├── OrdemServicoRepository.java
│   │   ├── ClienteRepository.java
│   │   ├── PecaRepository.java
│   │   └── ...
│   ├── model/                       # Entidades JPA (mapeamento de tabelas)
│   │   ├── OrdemServico.java
│   │   ├── Cliente.java
│   │   ├── Veiculo.java
│   │   ├── ItemServico.java
│   │   ├── ItemPeca.java
│   │   ├── Peca.java
│   │   ├── ServicoPadrao.java
│   │   ├── TransacaoCaixa.java
│   │   ├── Agendamento.java
│   │   └── Usuario.java
│   └── dto/                         # Data Transfer Objects (formulários/records)
│       ├── NovaOsDTO.java
│       ├── ItemServicoDTO.java
│       ├── ItemPecaDTO.java
│       ├── OsExtraInfoDTO.java
│       ├── TransacaoDTO.java
│       └── ...
└── resources/
    ├── application.properties       # Configurações (datasource, porta, JPA)
    ├── db/migration/
    │   └── V1__criar_tabelas_iniciais.sql  # Migration Flyway (schema inicial)
    ├── templates/                   # Templates Thymeleaf (HTML)
    │   ├── layout/                  # Base HTML e navbar
    │   ├── fragmentos/              # Fragmentos reutilizáveis (toasts, etc.)
    │   ├── os/                      # Telas de Ordens de Serviço
    │   ├── dashboard/
    │   ├── caixa/
    │   ├── clientes/
    │   ├── estoque/
    │   ├── agenda/
    │   ├── relatorios/
    │   ├── servicos/
    │   ├── usuarios/
    │   └── login.html
    └── static/                      # CSS, JS e imagens
```

---

## 🗄️ Modelo de Dados

```
┌─────────────┐       ┌──────────────────┐       ┌───────────────┐
│   clientes  │──────<│  ordens_servico  │>──────│    veiculos   │
│─────────────│       │──────────────────│       │───────────────│
│ id          │       │ id               │       │ id            │
│ nome        │       │ numero_os        │       │ modelo        │
│ celular     │       │ situacao         │       │ placa_chassi  │
│ email       │       │ problema_recl.   │       │ ano           │
│ cpf_cnpj    │       │ total_servicos   │       │ prisma        │
│ endereco    │       │ total_pecas      │       │ cliente_id FK │
└─────────────┘       │ frete            │       └───────────────┘
                      │ valor_total      │
                      │ cliente_id FK    │
                      │ veiculo_id FK    │
                      └────────┬─────────┘
                    ┌──────────┴──────────┐
          ┌─────────┴──────┐    ┌─────────┴──────┐
          │  itens_servico │    │   itens_peca   │
          │────────────────│    │────────────────│
          │ descricao      │    │ descricao      │
          │ quantidade     │    │ quantidade     │
          │ valor_unitario │    │ valor_unitario │
          │ tecnico        │    │ codigo_peca    │
          └────────────────┘    └────────────────┘

┌───────────────────┐    ┌──────────────┐    ┌──────────────────┐
│  transacoes_caixa │    │     pecas    │    │   usuarios       │
│───────────────────│    │──────────────│    │──────────────────│
│ descricao         │    │ codigo       │    │ username         │
│ tipo (ENT/SAI)    │    │ descricao    │    │ password (BCrypt) │
│ valor             │    │ qtd_estoque  │    │ role             │
│ status            │    │ preco_venda  │    └──────────────────┘
│ data_vencimento   │    └──────────────┘
│ forma_pagamento   │
└───────────────────┘
```

---

## 🚀 Como Executar Localmente

### Pré-requisitos

- **Java 21+** — [Download](https://adoptium.net/)
- **Maven 3.9+** — ou use o wrapper `./mvnw` incluído no projeto
- **PostgreSQL** — instância local ou conta gratuita no [Neon](https://neon.tech/)

### 1. Clone o repositório

```bash
git clone https://github.com/lucachak/Gen.git
cd Gen
```

### 2. Configure as variáveis de ambiente

Crie um arquivo `.env` na raiz (ou exporte as variáveis no seu terminal):

```bash
export DATABASE_URL=jdbc:postgresql://<host>/<database>?sslmode=require
export DATABASE_USER=<seu_usuario>
export DATABASE_PASS=<sua_senha>
```

> **Nota:** O `application.properties` já suporta essas variáveis com valores padrão de fallback. Para produção, **sempre use variáveis de ambiente**.

### 3. Execute a aplicação

```bash
# Com o Maven Wrapper (recomendado)
./mvnw spring-boot:run

# Ou diretamente com Maven
mvn spring-boot:run
```

A aplicação estará disponível em **http://localhost:8080**

### 4. Login padrão (criado automaticamente na 1ª execução)

| Campo | Valor |
|---|---|
| Usuário | `dalva` |
| Senha | `dalva` |
| Perfil | `ADMIN` |

> ⚠️ **Altere a senha padrão imediatamente** após o primeiro acesso em **/perfil**.

---

## 🐳 Deploy com Docker

### Build local da imagem

```bash
docker build -t cambiomatic .
```

### Executar o container

```bash
docker run -p 8080:8080 \
  -e DATABASE_URL=jdbc:postgresql://<host>/<db>?sslmode=require \
  -e DATABASE_USER=<usuario> \
  -e DATABASE_PASS=<senha> \
  cambiomatic
```

O `Dockerfile` usa **multi-stage build**:
- **Estágio 1 (`build`):** Maven + JDK 21 Alpine — compila e empacota o `.jar`
- **Estágio 2 (`run`):** JRE 21 Alpine — imagem mínima para produção

---

## ☁️ Deploy em Produção (Render)

1. Crie um novo **Web Service** no [Render](https://render.com/) apontando para este repositório
2. Defina as variáveis de ambiente (`DATABASE_URL`, `DATABASE_USER`, `DATABASE_PASS`) no painel do Render
3. O Render irá detectar o `Dockerfile` e construir a imagem automaticamente

### Keep-Alive (plano gratuito)

O plano gratuito do Render hiberna a aplicação após inatividade. O script `keep_alive.py` faz pings periódicos (a cada 60–90 segundos) para manter a aplicação ativa:

```bash
python3 keep_alive.py
```

> Para automatizar, configure um **GitHub Actions** agendado (`cron`) que execute este script.

---

## 🔑 Rotas Principais

| Rota | Método | Acesso | Descrição |
|---|---|---|---|
| `/` ou `/dashboard` | GET | ADMIN | Painel com KPIs e gráficos |
| `/os` | GET | Todos | Listagem paginada de OS |
| `/os/nova` | GET/POST | Todos | Criar nova OS |
| `/os/{id}` | GET | Todos | Detalhes da OS |
| `/os/{id}/fechar` | POST | Todos | Encerrar OS |
| `/os/{id}/imprimir` | GET | Todos | Impressão da OS |
| `/os/kanban` | GET | ADMIN | Quadro Kanban |
| `/clientes` | GET | Todos | Listagem de clientes |
| `/estoque` | GET | Todos | Listagem de peças |
| `/servicos` | GET | Todos | Serviços padrão |
| `/caixa` | GET | ADMIN | Fluxo de caixa |
| `/caixa/exportar` | GET | ADMIN | Exportar CSV |
| `/relatorios/comissoes` | GET | ADMIN | Relatório por técnico |
| `/agenda` | GET | ADMIN | Agenda |
| `/usuarios` | GET | ADMIN | Gestão de usuários |
| `/backup` | GET | ADMIN | Download de backup SQL |
| `/perfil` | GET | Todos | Perfil do usuário logado |
| `/login` | GET/POST | Público | Autenticação |
| `/logout` | POST | Todos | Encerrar sessão |

---

## 🏗️ Decisões de Arquitetura

- **MVC com Thymeleaf:** Renderização server-side para máxima simplicidade e SEO. Nenhuma complexidade de SPA desnecessária para um sistema interno.
- **HTMX:** Atualizações parciais da página (adicionar item, mudar status no kanban, toasts) sem escrever JavaScript customizado — mantendo o backend como única fonte de verdade.
- **Flyway:** Versionamento de schema do banco de dados. Garante que qualquer deploy novo parte de um schema consistente.
- **Lombok:** Elimina boilerplate de getters/setters/construtores nos models e services.
- **Records (DTOs):** Uso de Java Records para DTOs imutáveis e compactos.
- **CSRF desativado:** Necessário para o HTMX funcionar corretamente com formulários parciais. Em produção, considere configurar uma estratégia de CSRF compatível com HTMX.

---

## 📄 Licença

Projeto proprietário. Todos os direitos reservados.

---

*Desenvolvido por **Lucas Lucachak***