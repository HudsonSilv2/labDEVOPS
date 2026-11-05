# Atividade #1 — Gerenciamento de Contêineres

Projeto **local e mínimo**, com **3 contêineres**:

- `frontend`: site HTML/CSS/JavaScript servido pelo Nginx (porta local **8080**).
- `backend`: API Node.js + TypeScript (porta interna **3000**).
- `banco`: PostgreSQL (porta interna **5432**).

```text
Navegador (localhost:8080)
          |
       frontend (Nginx)
          | /api/status
       backend (Node)
          | SELECT 1
       banco (PostgreSQL)

Todos usam a rede Docker: rede-atividade
```

## 1. Requisitos

Linux com **Docker Engine** instalado (não precisa de Docker Desktop).

Confira:

```bash
docker --version
docker info
```

Se ainda não instalou, siga a [documentação oficial do Docker Engine](https://docs.docker.com/engine/install/) para a sua distribuição Linux. O terminal deve conseguir executar `docker` (com permissões adequadas). Imagens e dependências são baixadas da internet no primeiro build.

## 2. Executar — um comando

No terminal, **dentro desta pasta**:

```bash
bash iniciar.sh
```

Abra **http://localhost:8080** e espere aparecer:

```text
Frontend: online
Backend: online
Banco: conectado
```

Se inicialmente mostrar `Banco: indisponível`, clique em **Testar conexão** depois que o PostgreSQL terminar de iniciar.

Para parar:

```bash
bash parar.sh
```

## 3. Evidências no terminal

```bash
# Versão do Docker Engine
docker --version

# Os três contêineres em execução
docker ps

# Rede criada e os três contêineres conectados
docker network inspect rede-atividade

# Testa o frontend e a comunicação com o backend e banco
curl http://localhost:8080/api/status

# Executa uma consulta diretamente no PostgreSQL
docker exec banco psql -U aluno -d atividade -c "SELECT 1;"

# Logs do backend
docker logs backend

# Imagens construídas
docker images atividade-backend
docker images atividade-frontend
```

Salve os prints em **`evidencias/`** seguindo o arquivo [evidencias/README.md](evidencias/README.md).

## 4. Publicar imagens no GitLab Container Registry

**Opcional durante o desenvolvimento local, mas obrigatório para cumprir o passo 4 e 5 da atividade.** Peça ao practitioner para habilitar o Container Registry no repositório.

Substitua `SEU_USUARIO/SEU_PROJETO` pelo caminho real do projeto GitLab. Se o GitLab for institucional, use o endereço de registry mostrado pelo próprio GitLab (pode ser diferente de `registry.gitlab.com`).

```bash
# Exemplo para gitlab.com:
docker login registry.gitlab.com

docker tag atividade-backend registry.gitlab.com/SEU_USUARIO/SEU_PROJETO/backend:latest
docker push registry.gitlab.com/SEU_USUARIO/SEU_PROJETO/backend:latest

docker tag atividade-frontend registry.gitlab.com/SEU_USUARIO/SEU_PROJETO/frontend:latest
docker push registry.gitlab.com/SEU_USUARIO/SEU_PROJETO/frontend:latest
```

Capture a tela do GitLab em **Deploy > Container Registry** mostrando as duas imagens. O login poderá exigir token de acesso com permissão `write_registry`.

## 5. Onde os requisitos foram atendidos

| Requisito | Local |
| --- | --- |
| Docker Engine | instalação local, `docker --version` |
| Dockerfile Backend | `backend/Dockerfile` |
| Multi-stage Backend e compilação TS | `backend/Dockerfile` (build + runtime) |
| GitLab Registry Backend | comandos da seção 4 |
| Dockerfile + Multi-stage Frontend | `frontend/Dockerfile` |
| GitLab Registry Frontend | comandos da seção 4 |
| PostgreSQL | `iniciar.sh` (`docker run ... postgres:16-alpine`) |
| Rede bridge personalizada | `iniciar.sh` (`rede-atividade`) |
| Variáveis de ambiente do Backend | `iniciar.sh` (`DB_HOST`, etc.) |
| Frontend acessa Backend | `frontend/nginx.conf` (`/api` → `backend`) |
| Reflexões + prints | `RELATORIO.md` + `evidencias/` |

**Importante:** esta é uma aplicação **de exemplo**, não o backend/frontend real de *Software Development 4*. Se a correção exigir os projetos originais, adapte os Dockerfiles aos códigos daquela disciplina. A estrutura da rede, banco, variáveis e registro continua válida.

**Segurança:** `aluno/senha123` é uma credencial didática local. Não use essa senha em produção nem publique dados reais no repositório.
