# /bin/sh

docker compose -f postgres/docker-compose.yml up -d
go run . postgres