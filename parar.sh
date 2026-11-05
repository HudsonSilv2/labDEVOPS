#!/usr/bin/env bash
set -euo pipefail
docker rm -f frontend backend banco
printf 'Contêineres parados. Volume dados-atividade preservado.\n'
