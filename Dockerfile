FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY much-todo/Server/MuchToDo/go.mod much-todo/Server/MuchToDo/go.sum ./
RUN go mod download

COPY much-todo/Server/MuchToDo/ .

RUN CGO_ENABLED=0 GOOS=linux go build -o muchtodo ./cmd/api

FROM alpine:latest

RUN apk --no-cache add curl

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/muchtodo .
COPY .env .

RUN chown appuser:appgroup /app/muchtodo

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

CMD ["./muchtodo"]
