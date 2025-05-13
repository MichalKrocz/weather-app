# Budowanie aplikacji Go z wykorzystaniem oficjalnego obrazu
FROM golang:1.20 AS builder

# Ustawienie katalogu roboczego w kontenerze
WORKDIR /app
COPY . .

RUN go mod tidy

# Budowanie aplikacji jako statyczna binarka bez zależności do libc (CGO_DISABLED=0)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go


# Tworzenie finalnego obrazu na bazie Debiana
FROM debian:bullseye-slim

# Metadane obrazu
LABEL org.opencontainers.image.authors="Michał Krocz" \
      version="1.0" \
      description="Prosta aplikacja pogodowa w Go"

# Instalacja curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Kopiowanie plików
COPY --from=builder /app/app /app/
COPY --from=builder /app/static /static/

# Umożliwienie wystawienia portu kontenera
ENV PORT=8080

EXPOSE 8080
CMD ["/app/app"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:8080/ || exit 1
