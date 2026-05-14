# Anıl Sezgin — Personal Portfolio & CV

A minimalist dark-mode portfolio website and Typst CV for Anıl Sezgin, Senior AOSP & BSP Developer.

## Project Structure

```
my_website/
├── index.html                  # Portfolio website (SPA)
├── cv.typ                      # Typst CV source
├── Anil_Sezgin_CV.pdf          # Compiled CV (linked from download button)
└── README.md
```

## Compiling the CV

### Prerequisites

Install Typst:

**Windows:**
```bash
winget install --id Typst.Typst
```

**macOS:**
```bash
brew install typst
```

**Ubuntu/Debian:**
```bash
curl -fsSL https://typst.community/typst-install/install.sh | bash
```

### Compile

```bash
typst compile cv.typ Anil_Sezgin_CV.pdf
```

## Running the Website Locally

The website is a single static HTML file with no build step.

**Using Python:**
```bash
python3 -m http.server 8000
```
Then open [http://localhost:8000](http://localhost:8000) in your browser.

**Using Node.js (npx):**
```bash
npx serve .
```

## Deployment

### GitHub Pages

1. Push this repository to GitHub.
2. Go to **Settings → Pages**.
3. Under **Source**, select the `main` branch and `/` (root) folder.
4. Click **Save**. Your site will be live at `https://<username>.github.io/my_website/`.

### Vercel

1. Install the Vercel CLI:
   ```bash
   npm i -g vercel
   ```
2. Deploy:
   ```bash
   vercel --prod
   ```

## Tech Stack

- **HTML5** — Semantic markup
- **Tailwind CSS** — Utility-first styling via CDN
- **Font Awesome** — Icons via CDN
- **Vanilla JavaScript** — Tab switching & fade-in animations
- **Typst** — Modern CV typesetting
