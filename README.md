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

## Theme

One layout, two palettes. Light is Paper terminal (warm paper, teal accent).
Dark is Slate IDE (slate background, green accent, cyan links). Fonts, grid,
navbar and search chrome stay the same; only the color tokens change.

The site follows `prefers-color-scheme` on first visit
(`respect-user-color-scheme: true` in `_quarto.yml`). A Light/Dark control in
the navbar overrides that and Quarto stores the choice in localStorage. Palette
tokens live in `styles.css` under `body.quarto-light` / `body.quarto-dark`.
Bootstrap variables for each mode are in `theme-light.scss` and
`theme-dark.scss`.

Code blocks keep Quarto/Pandoc syntax highlighting (`highlight-style: atom-one`).
Token colors switch with the page theme. They are not flattened to a single grey.

## Writing style

**Plain ASCII only.** No em dashes, curly quotes, arrows, ellipsis characters or any other
symbol you cannot type on a standard keyboard. Where a sentence wants an em dash, rewrite
it or use a colon, a comma or brackets.

Pandoc's smart typography is switched off in `_quarto.yml` (`from: markdown-smart`).
Leave it off. With it on, Pandoc silently turns straight quotes into curly ones and `--`
into an en dash at render time, so an all-ASCII source still publishes characters that
are not on a keyboard.

Two things on the rendered pages are not ASCII and are deliberately left alone: real R
console output (rlang prints characters like the info bullet in its error messages, and
faking that would make the examples wrong), and Quarto's own browser-tab separator in
`<title>`, which is hardcoded in the Pandoc template and would need a custom template to
change. Neither appears in page content.

`tools/check-ascii.sh` enforces this. It runs in CI before the render, so a page with a
stray em dash fails the build. Run it yourself before pushing:

```bash
bash tools/check-ascii.sh
```

## Adding a topic

1. Write `_quickref/<topic>.md` first: the code, with a one-line comment on each call,
   plus the SAS mapping table. This is the essence of the topic and nothing else. It is a
   plain `r` block, not an executed chunk, so keep it short enough that it cannot drift
   from the worked examples below it.
2. Create `<topic>.qmd` in the project root, and pull the block in near the top with
   `{{< include _quickref/<topic>.md >}}`.
3. Open it with a `::: {.sas-equiv} **SAS:** ... :::` block naming the SAS procedures,
   statements or functions it replaces. The site search indexes this, which is how
   readers looking for `PROC TRANSPOSE` find the reshaping page.
4. Add the topic to the list in `index.qmd`.
5. If it uses a package not already installed in CI, add it to
   `.github/workflows/publish.yml` and `.github/workflows/pr-preview.yml`.
6. Run `bash tools/check-ascii.sh` before pushing.

Also add the topic to `cheatsheet.qmd` with a `## [Topic](topic.qmd)` heading and the
same `{{< include >}}` line. The include is why there is one copy of the essence and two
places it appears. Never paste it.

Files under `_quickref/` are includes, not pages: the leading underscore keeps Quarto from
rendering them standalone.

Examples on the topic pages are executed at render time, so a broken example fails the
build rather than sitting wrong on the page. The quick-reference blocks are not executed,
so treat the worked examples below them as the thing that proves the code.

## Publishing

Every push to `main` renders the site and pushes the result to the `gh-pages` branch
(root of the Pages site). Pages is enabled automatically on the first successful
publish, pointed at `gh-pages`. No manual setup in Settings is needed.

Pull requests also get a preview: `.github/workflows/pr-preview.yml` renders the
branch and deploys it to `pr-preview/pr-<number>/` on `gh-pages`, then comments the
URL on the PR. Open that link to click through the proposed site without merging.
Closing the PR removes the preview. Main publishes leave `pr-preview/` in place.

Note that the first Pages publish still needs a `gh-pages` branch to exist. If you
ever start a second site from this template, push an empty orphan `gh-pages` branch
before the first build.
