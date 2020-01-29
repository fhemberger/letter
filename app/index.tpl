<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>{{ .Title }}</title>

  <meta name="robots" content="noindex, nofollow, noodp">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="icon" href="/static/letter.png" type="image/png" />
  <link rel="stylesheet" href="/static/defaults.css" media="all">
  <style>
    {{ .Theme }}
  </style>
</head>
<body>
  <letter>

    <header>
      <address>
        <from>
          <name>{{ .Name }}</name>
          <street>{{ .Street }}</street>
          <city>{{ .City }}</city>
          {{ if .Country -}}
          <country>{{ .Country }}</country>
          {{- end }}
        </from>
        <to contenteditable>
          {{ .Placeholders.Address }}
        </to>
      </address>
    </header>

    <main>
      <subject contenteditable>{{ .Placeholders.Subject }}</subject>
      <date contenteditable></date>
      <text contenteditable>
        {{ .Placeholders.Text }}
      </text>
      <signature>
        <closing contenteditable>{{ .Closing }}</closing>
        <name contenteditable>{{ .Name }}</name>
        {{ if .Signature -}}
        <img src="data:image/png;base64,{{ .Signature }}">
        {{- end }}
      </signature>
    </main>

    <footer>

      <address>
        <name>{{ .Name }}</name>
        <street>{{ .Street }}</street>
        <city>{{ .City }}</city>
        {{ if .Country -}}
        <country>{{ .Country }}</country>
        {{- end }}
      </address>

      <contact>

        {{ if .Phone -}}
        <phone>
          <label>{{ .Labels.Phone }}</label> {{ .Phone }}
        </phone>
        {{- end }}

        {{ if .Mobile -}}
        <mobile>
          <label>{{ .Labels.Mobile }}</label> {{ .Mobile }}
        </mobile>
        {{- end }}

        {{ if .Email -}}
        <email>
          <label>{{ .Labels.Email }}</label> {{ .Email }}
        </email>
        {{- end }}

        {{ if .Website -}}
        <website>
          <label>{{ .Labels.Website }}</label> {{ .Website }}
        </website>
        {{- end }}

      </contact>

      {{ if .Bank -}}
      <bank>

        <name>
          <label>{{ .Labels.Bank }}</label> {{ .Bank }}
        </name>

        {{ if .Iban -}}
        <iban>
          <label>{{ .Labels.Iban }}</label> {{ .Iban }}
        </iban>
        {{- end }}

        {{ if .Bic -}}
        <bic>
          <label>{{ .Labels.Bic }}</label> {{ .Bic }}
        </bic>
        {{- end }}

      </bank>
      {{- end }}

      {{ if or .VatID .TaxID -}}
      <info>

        {{ if .VatID -}}
        <vatid>
          <label>{{ .Labels.VatID }}</label> {{ .VatID }}
        </vatid>
        {{- end }}

        {{ if .TaxID -}}
        <taxid>
          <label>{{ .Labels.TaxID }}</label> {{ .TaxID }}
        </taxid>
        {{- end}}

      </info>
      {{- end }}

    </footer>
  </letter>

  <selectiontools id="selectiontools">
    <button id="btn-bold"><strong>B</strong></button>
    <button id="btn-italic"><em>I</em></button>
    <script src="/static/js/selectiontools.js" async defer></script>
  </selectiontools>

  <script defer>
    var date = document.getElementsByTagName('date')[0]
    date.innerHTML = (new Date()).toLocaleDateString()
  </script>
</body>
</html>
