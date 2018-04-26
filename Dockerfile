FROM golang:1.10.1-alpine as build
WORKDIR /go/src

RUN apk add git php5-cli --no-cache \
  && git clone --depth=1 https://github.com/bastianallgeier/letter.git .
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags="-s -w" static-server.go
RUN php5 -f index.php > index.html

FROM scratch
# RUN mkdir -p app/js
COPY --from=build /go/src/static-server /
COPY --from=build /go/src/index.html /static/
COPY --from=build /go/src/app/js/selectiontools.js /static/app/js/

EXPOSE 3000
CMD ["./static-server"]
