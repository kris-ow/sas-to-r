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
4. Add the file to the `sidebar` contents in `_quarto.yml`, and link it from the topic
   list in `index.qmd`.
5. If it uses a package not already installed in CI, add it to
   `.github/workflows/publish.yml`.
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

Every push to `main` renders the site and pushes the result to the `gh-pages` branch.
Pages is enabled automatically on the first successful publish, pointed at `gh-pages`.
No manual setup in Settings is needed.

Note that `quarto publish gh-pages` will not create the branch itself when it runs in CI.
If you ever start a second site from this template, push an empty orphan `gh-pages`
branch before the first build.
