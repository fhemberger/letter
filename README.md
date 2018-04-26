# Letter

[Letter](https://github.com/bastianallgeier/letter) is a simple, highly customizable tool to create letters in your browser.

[![Letter Screenshot](https://bastianallgeier.com/projects/letter/screenshot.png)](https://bastianallgeier.com/projects/letter/)

This is a static, containerized version of Letter.

Instead of serving the webpage dynamically through PHP, it's compiled to a static HTML file and served from a tiny web-server in Go, using only a fraction of the originally required resources.


## Usage

1. Create a sub-directory `config` and adjust the settings of the [original repository](https://github.com/bastianallgeier/letter/tree/master/config) to match your needs.
2. Run `start.sh` to start a Docker container with the application
3. The web-server is exposed on `http://localhost:3000`. Happy writing.


## Advanced usage

If you're running Docker for Mac (or Windows), you can use a reverse proxy like [Træfik]() to make Letter accessible under `http://letter.docker.localhost`:

```toml
# traefik.toml
checkNewVersion = false

[web]
address = ":8080"

[docker]
domain = "docker.localhost"
watch = true
```

```bash
docker run -d -p 80:80 \
  --restart on-failure:3 \
  -v "$PWD/traefik.toml:/etc/traefik/traefik.toml:ro" \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -l traefik.frontend.rule=Host:traefik.docker.localhost \
  -l traefik.port=8080 \
  --name traefik \
  traefik
```


## License

[MIT](LICENSE.txt)
