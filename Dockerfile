FROM golang:1.11-alpine as build
WORKDIR /go/src

COPY app app
COPY config config
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags="-s -w" main.go

FROM scratch
COPY --from=build /go/src/main /
COPY --from=build /go/src/config /config/
COPY --from=build /go/src/app /app/

EXPOSE 3000
CMD ["./main"]
