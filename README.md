# sas-to-r

Source for **SAS to R**, a practical reference for SAS programmers writing R.

Published at <https://kris-ow.github.io/sas-to-r/>.

## Building locally

Requires [Quarto](https://quarto.org) and R, plus the packages the examples use
(currently `dplyr`).

```bash
quarto preview     # live reload while writing
quarto render      # build once into _site/
```

## Writing style

**Plain ASCII only.** No em dashes, curly quotes, arrows, ellipsis characters or any other
symbol you cannot type on a standard keyboard. Where a sentence wants an em dash, rewrite
it or use a colon, a comma or brackets.

`tools/check-ascii.sh` enforces this. It runs in CI before the render, so a page with a
stray em dash fails the build. Run it yourself before pushing:

```bash
bash tools/check-ascii.sh
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
5. Run `bash tools/check-ascii.sh` before pushing.

Examples are executed at render time, so a broken example fails the build rather than
sitting wrong on the page.

## Publishing

Every push to `main` renders the site and pushes the result to the `gh-pages` branch.
Pages is enabled automatically on the first successful publish, pointed at `gh-pages`.
No manual setup in Settings is needed.

Note that `quarto publish gh-pages` will not create the branch itself when it runs in CI.
If you ever start a second site from this template, push an empty orphan `gh-pages`
branch before the first build.
