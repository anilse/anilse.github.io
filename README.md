# Anıl Sezgin — Personal Portfolio & CV

A minimalist dark-mode portfolio website and Typst CV for Anıl Sezgin, Senior AOSP & BSP Developer.

## Architecture

`data.json` is the single source of truth — both the website and CV read from it.

```
├── data.json           # All CV data (single source of truth)
├── index.html          # Portfolio website (reads data.json)
├── cv.typ              # Typst CV source (reads data.json)
├── Anil_Sezgin_CV.pdf  # Compiled CV
├── serve.cmd           # Local dev server
├── validate.sh         # Pre-commit validation
├── .githooks/          # Shared git hooks
└── README.md
```

## Setup

After cloning, enable the shared pre-commit hooks:
```bash
git config core.hooksPath .githooks
```

## Local Development

```bash
serve.cmd
```
Then open [http://localhost:8000](http://localhost:8000).

## Compiling the CV

Install [Typst](https://typst.app):
```bash
winget install --id Typst.Typst   # Windows
brew install typst                 # macOS
```

Compile:
```bash
typst compile cv.typ Anil_Sezgin_CV.pdf
```

## Deployment

Hosted on **Cloudflare Pages** at [anilsezgin.dev](https://anilsezgin.dev). Auto-deploys on push to `main`.

## Tech Stack

- **HTML5 + Tailwind CSS + Vanilla JS** — Portfolio website
- **Typst** — CV typesetting
- **data.json** — Shared data between website and CV
