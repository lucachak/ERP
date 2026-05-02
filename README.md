# 🚗 Cambiomatic (Gen) 

> Um sistema ERP web completo e otimizado para a gestão eficiente de oficinas mecânicas.

[![Live Demo](https://img.shields.io/badge/Live_Demo-Cambiomatic-blue?style=for-the-badge&logo=render)](https://cambiomatic.onrender.com/)
[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-black?style=for-the-badge&logo=github)](https://www.github.com/lucachak/Gen)

O **Cambiomatic** é uma aplicação focada em resolver os desafios diários de uma oficina mecânica. Sem depender de IA ou soluções mirabolantes, o sistema entrega o que realmente importa: velocidade, estabilidade e controle prático sobre ordens de serviço, clientes e fluxo de trabalho.

---

## ✨ Funcionalidades Principais

* **Gestão de Ordens de Serviço (OS):** Criação, acompanhamento de status e finalização de serviços veiculares.
* **Cadastro de Clientes e Veículos:** Histórico completo de manutenções por placa e proprietário.
* **Controle de Estoque (Peças):** Monitoramento de entradas e saídas de peças utilizadas nos serviços.
* **Painel Administrativo:** Visão geral do pátio e das métricas financeiras/operacionais da oficina.

---

## 🛠️ Tecnologias Utilizadas

A arquitetura foi pensada para ser robusta, escalável e de fácil manutenção, separando claramente as responsabilidades do cliente e do servidor.

### **Frontend**
* **React:** Construção de uma interface de usuário dinâmica, rápida e reativa.
* Integração direta com a API REST do backend para consumo de dados em tempo real.

### **Backend**
* **Java & Spring Boot:** API RESTful robusta, com segurança integrada e injeção de dependências eficiente.

### **Banco de Dados & Infraestrutura**
* **PostgreSQL (Neon Database):** Banco de dados relacional serverless, garantindo alta disponibilidade e performance.
* **Render:** Plataforma de cloud hosting utilizada para o deploy do servidor.
* **Script de Keep-Alive:** Um script de requisições constantes (cron/ping) implementado para evitar o *cold start* (hibernação) no plano gratuito do Render, garantindo que o ERP esteja sempre rápido e responsivo para o usuário final.

---

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos
* [Node.js](https://nodejs.org/) (para o frontend React)
* [Java 17+](https://www.oracle.com/java/technologies/javase-downloads.html) (para o backend Spring Boot)
* [Maven](https://maven.apache.org/) ou wrapper equivalente
* Uma conta no [Neon](https://neon.tech/) para configurar seu banco PostgreSQL localmente ou em nuvem.

### Passos para Instalação

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/lucachak/Gen.git](https://github.com/lucachak/Gen.git)
   cd Gen