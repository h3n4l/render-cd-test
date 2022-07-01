FROM golang:1.18 as backend

RUN mkdir -p /app

WORKDIR /app/

COPY . .

RUN CGO_ENABLED=0 go build -o app main.go

FROM alpine:3.14.3 as monolithic

WORKDIR /

COPY --from=backend /app/app .

EXPOSE 80

CMD [ "/app" ]
