```r
library(dplyr)

bind_rows(ae_site_a, ae_site_b)

bind_rows(
  list(SITEA = ae_site_a, SITEB = ae_site_b),
  .id = "SITE"
)
```

| R | SAS |
|---|---|
| `bind_rows(a, b)` | `set a b;` (stack; align names with `rename=` if needed) |
| `bind_rows(..., .id = "SRC")` | `set a b indsname=src;` |
| `bind_rows()` by column name | `PROC SQL` `OUTER UNION CORR` |

Traps: `bind_rows()` matches columns by name, not position. Character versus numeric on the same name errors in dplyr; fix types before stacking. SAS `SET` takes character length from the first dataset and can truncate later values; `bind_rows()` does not truncate.
