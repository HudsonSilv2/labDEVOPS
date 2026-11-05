# Relatório — Atividade #1: Gerenciamento de Contêineres

## Objetivo

Criar um ambiente local com Frontend, Backend e PostgreSQL usando Docker Engine. Utilizar multi-stage builds para gerar imagens finais mais simples e conectar os três contêineres pela mesma rede.

## Implementação

- **Backend:** Node.js e TypeScript. O Docker compila o código na primeira etapa e executa somente o JavaScript e as dependências necessárias na etapa final.
- **Frontend:** HTML, CSS e JavaScript. A primeira etapa prepara os arquivos; o Nginx Alpine os serve na imagem final, sem Node.js.
- **Banco:** PostgreSQL em contêiner próprio, com volume persistente.
- **Rede:** `rede-atividade`, do tipo bridge, permite acesso pelos nomes `frontend`, `backend` e `banco`.
- **Integração:** o navegador acessa `localhost:8080`; o Nginx encaminha `/api/status` para `backend:3000`; a API testa a conexão com `banco:5432`.

## Evidências

> Inserir as capturas com os nomes indicados. Salvar os arquivos na pasta `evidencias/`.

### 1. Docker Engine

![Docker Engine instalado](evidencias/01-docker-engine.png)

### 2. Build do Backend

![Docker build do backend](evidencias/02-build-backend.png)

### 3. Build do Frontend

![Docker build do frontend](evidencias/03-build-frontend.png)

### 4. Três contêineres em execução

![docker ps](evidencias/04-containers.png)

### 5. Rede Docker

![docker network inspect](evidencias/05-rede.png)

### 6. Banco PostgreSQL

![Consulta SQL no PostgreSQL](evidencias/06-banco.png)

### 7. Frontend funcionando

![Frontend no navegador](evidencias/07-site.png)

### 8. API funcionando

![curl na API](evidencias/08-api.png)

### 9. GitLab Container Registry

![Imagens no registry](evidencias/09-registry.png)

## Conclusões

A atividade demonstrou como separar Frontend, Backend e Banco de Dados em contêineres independentes. Com a rede bridge personalizada, os serviços se comunicam usando os nomes dos contêineres. Os multi-stage builds permitem deixar ferramentas de compilação fora das imagens finais, reduzindo o tamanho e a complexidade do ambiente de execução. As variáveis de ambiente facilitam configurar o Backend sem alterar o código. O Container Registry do GitLab permite armazenar e distribuir as imagens construídas.

## Observação sobre a entrega

Os prints acima são espaços reservados até serem capturados no computador onde o Docker Engine será executado. A publicação no GitLab deve ser realizada com as credenciais do repositório da disciplina.
