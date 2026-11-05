#!/usr/bin/env bash
set -euo pipefail

# Imagens locais
printf '\n[1/4] Construindo backend e frontend...\n'
docker build -t atividade-backend ./backend
docker build -t atividade-frontend ./frontend

# Rede e armazenamento persistente
printf '\n[2/4] Preparando rede e volume...\n'
docker network inspect rede-atividade >/dev/null 2>&1 || docker network create rede-atividade
docker volume inspect dados-atividade >/dev/null 2>&1 || docker volume create dados-atividade

# Limpa contêineres antigos, preservando o volume do banco.
for nome in frontend backend banco; do
  docker rm -f "$nome" >/dev/null 2>&1 || true
done

printf '\n[3/4] Subindo PostgreSQL e backend...\n'
docker run -d --name banco --network rede-atividade \
  -e POSTGRES_USER=aluno -e POSTGRES_PASSWORD=senha123 \
  -e POSTGRES_DB=atividade -v dados-atividade:/var/lib/postgresql/data \
  postgres:16-alpine

docker run -d --name backend --network rede-atividade \
  -e DB_HOST=banco -e DB_USER=aluno \
  -e DB_PASSWORD=senha123 -e DB_NAME=atividade \
  atividade-backend

printf '\n[4/4] Subindo frontend...\n'
docker run -d --name frontend --network rede-atividade \
  -p 8080:80 atividade-frontend

printf '\nAbra: http://localhost:8080\n'
printf 'Teste da API: curl http://localhost:8080/api/status\n'
printf 'Se o banco ainda estiver iniciando, clique em Testar conexão novamente.\n'
