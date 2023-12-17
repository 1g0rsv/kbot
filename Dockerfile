# Стадия сборки
FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .
ARG TARGETARCH
RUN make build TARGETARCH=$TARGETARCH

# Промежуточный образ для данных о временных зонах
FROM alpine:latest as tzdata

RUN apk add --no-cache tzdata

# Финальный образ
FROM scratch

WORKDIR /
COPY --from=builder /go/src/app/kbot2 .
COPY --from=tzdata /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Установка переменной окружения TELE_TOKEN
#ENV TELE_TOKEN 6984636063:AAFUdAyheJ8SKTEh5tl2QxfYSlfIq

ENTRYPOINT ["./kbot2", "go"]
