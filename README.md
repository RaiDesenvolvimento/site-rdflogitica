# RDF Logistica

Site estatico exportado em HTML.

## Rodar localmente

```bash
python3 -m http.server 8000
```

Acesse:

```text
http://localhost:8000/
```

## Build de producao

```bash
bash scripts/build-static.sh
```

O build gera a pasta `dist/` com os arquivos esperados pela navegacao:

- `index.html`
- `Home.html`
- `COMEX.html`
- `Logistica.html`
- `Sobre.html`
- `Contato.html`

## Deploy via GitHub Actions

O workflow `.github/workflows/deploy.yml` publica o conteudo de `dist/` no GitHub Pages quando houver push na branch `main`.

No GitHub, va em:

```text
Settings > Pages > Build and deployment > Source > GitHub Actions
```

Depois faca push para `main`.
