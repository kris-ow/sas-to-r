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
| `bind_rows(..., .id = "SRC")` | add a source variable before `set` |
| `bind_rows()` by column name | `PROC SQL` `OUTER UNION CORR` |

Trap: `bind_rows()` matches columns by name, not position. A type clash on the same name (character vs numeric) errors or coerces; fix types before stacking.
