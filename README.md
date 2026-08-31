# sas-to-r

Source for **SAS to R** — a practical reference for SAS programmers writing R.

Published at <https://kris-ow.github.io/sas-to-r/>.

## Building locally

Requires [Quarto](https://quarto.org) and R, plus the packages the examples use
(currently `dplyr`).

```bash
quarto preview     # live reload while writing
quarto render      # build once into _site/
```

## Adding a topic

1. Create `<topic>.qmd` in the project root.
2. Open it with a `::: {.sas-equiv} **SAS:** ... :::` block naming the SAS procedures,
   statements or functions it replaces. The site search indexes this, which is how
   readers looking for `PROC TRANSPOSE` find the reshaping page.
3. Add the file to the `sidebar` contents in `_quarto.yml`, and link it from the topic
   list in `index.qmd`.
4. If it uses a package not already installed in CI, add it to
   `.github/workflows/publish.yml`.

Examples are executed at render time, so a broken example fails the build rather than
sitting wrong on the page.

## Publishing

Every push to `main` renders the site and pushes the result to the `gh-pages` branch.
GitHub Pages must be set to serve from that branch (Settings → Pages → Deploy from a
branch → `gh-pages` / root).
