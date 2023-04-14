# /bin/sh

docker compose -f cockroach/docker-compose.yml up -d
go run . cockroach