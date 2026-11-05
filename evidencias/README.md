# Onde guardar os prints

Coloque os arquivos de imagem aqui, com estes nomes:

1. `01-docker-engine.png` — terminal com `docker --version`.
2. `02-build-backend.png` — saída `docker build -t atividade-backend ./backend` (ou log do `bash iniciar.sh`).
3. `03-build-frontend.png` — saída `docker build -t atividade-frontend ./frontend`.
4. `04-containers.png` — terminal com `docker ps` mostrando `frontend`, `backend`, `banco`.
5. `05-rede.png` — terminal com `docker network inspect rede-atividade`.
6. `06-banco.png` — terminal com `docker exec banco psql -U aluno -d atividade -c "SELECT 1;"`.
7. `07-site.png` — navegador com `http://localhost:8080` exibindo tudo online.
8. `08-api.png` — terminal com `curl http://localhost:8080/api/status`.
9. `09-registry.png` — tela GitLab **Deploy > Container Registry** com as duas imagens.

Essas imagens aparecem automaticamente no [RELATORIO.md](../RELATORIO.md) quando você as salvar nesta pasta.
