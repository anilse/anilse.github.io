# Anıl Sezgin — Personal Portfolio & CV

A minimalist dark-mode portfolio website and Typst CV for Anıl Sezgin, Senior AOSP & BSP Developer.

## Architecture

`data.json` is the single source of truth — both the website and CV read from it.

```
├── data.json           # All CV data (single source of truth)
├── index.html          # Portfolio website (reads data.json)
├── cv.typ              # Typst CV source (reads data.json)
├── Anil_Sezgin_CV.pdf  # Compiled CV
├── validate.py         # Validation script (JSON, HTML5, Typst, security)
├── validate.sh         # Shell wrapper (runs validate.py via uv)
├── serve.cmd           # Local dev server
├── .githooks/          # Shared git hooks
└── README.md
```

## Setup

After cloning, enable the shared pre-commit hooks:
```bash
git config core.hooksPath .githooks
```

### Install uv (Python package manager)

[uv](https://docs.astral.sh/uv/) powers the pre-commit validation pipeline. Dependencies (like `html5lib`) are declared inline in `validate.py` and resolved automatically — no virtualenv or `pip install` needed.

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh   # Linux / WSL / macOS
winget install --id astral-sh.uv                    # Windows
```

After installation, make sure `~/.local/bin` is in your `PATH` (the installer usually adds it to `~/.bashrc` automatically).

## Local Development

```bash
serve.cmd
```
Then open [http://localhost:8000](http://localhost:8000).

## Compiling the CV

Install [Typst](https://typst.app):
```bash
# Linux / WSL — download binary to ~/.local/bin
curl -fsSL https://github.com/typst/typst/releases/download/v0.14.2/typst-x86_64-unknown-linux-musl.tar.xz \
  | tar -xJ --strip-components=1 -C ~/.local/bin/

# Windows
winget install --id Typst.Typst

# macOS
brew install typst
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
- **uv** — Python script runner for validation
- **data.json** — Shared data between website and CV
