FROM golang:1.18.2-alpine as build
WORKDIR /go/src

COPY app app
COPY config config
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags="-s -w" main.go
RUN adduser --system --no-create-home --uid 1000 --shell /usr/sbin/nologin letter

FROM scratch

LABEL org.opencontainers.image.title=Letter
LABEL org.opencontainers.image.description="Letter is a simple, highly customizable tool to create letters in your browser."
LABEL org.opencontainers.image.vendor="Frederic Hemberger"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.source=https://github.com/fhemberger/letter

COPY --from=build /go/src/main /
COPY --from=build /go/src/config /config/
COPY --from=build /go/src/app /app/
COPY --from=build /etc/passwd /etc/passwd

USER letter

EXPOSE 3000
CMD ["./main"]
