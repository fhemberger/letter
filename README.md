# Letter

Letter is a simple, highly customizable tool to create letters in your browser.

![Letter Screenshot](https://raw.githubusercontent.com/fhemberger/letter/master/_images/screenshot.png)

Instead of messing around in Word, Pages or even Indesign, you can write your letters in the browser, export them as HTML or PDF (via Apple Preview).

Written in plain HTML and CSS, Letter runs as a Docker container either on your machine or on a server. The [original version](https://github.com/bastianallgeier/letter) was written in PHP by [Bastian Allgeier](https://twitter.com/bastianallgeier/) and requires a separate web server. This version comes with a tiny web server written in Go, so you don’t need anything besides Docker.

You can setup your own letter template and customize the design with CSS.

## Usage

1. Adjust the [settings](#setup) in the `config` directory the to match your needs.
2. Start the docker container and include your configuration:

    ```sh
    docker run --rm \
      -p 3000:3000 \
      -v "$PWD/config:/config:ro" \
      --name letter \
      fhemberger/letter
    ```

3. The web-server is exposed on `http://localhost:3000`. Happy writing.


## How to …

### Save Letters

You can save your letters by simply using the browser save dialog. Make sure to choose "Save HTML only" as the export option. You will get a nice and clean HTML file of your letter, which can be kept for later at any place you prefer.

### Print Letters

Use your browser’s print dialog to print your finished Letters. Make sure to set "No margins" in your printing dialog to avoid broken dimensions of your document.

### Export PDFs

On macOS you can use your browser’s print dialog to export your Letter to PDF via Apple Preview. As long as you get the printing settings correct, the PDF will look good too.


## Setup

### Configuration

You can setup the global content of your Letter in `config/config.json`. Adjust the settings and add your own data there.


### Custom stylesheet

If you want to adjust Letter’s custom styles, go to `config/styles.css` and add your own CSS there. Check out Letter’s custom HTML tags in the browser for further information what to adjust.

### Signature

Replace Letter’s example signature.png in `config/signature.png` with your own, to load it automatically.


## Advanced usage

If you’re running Docker for Mac (or Windows), you can use a reverse proxy like [Træfik]() to make Letter accessible under `http://letter.docker.localhost`:

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

[MIT](LICENSE)
