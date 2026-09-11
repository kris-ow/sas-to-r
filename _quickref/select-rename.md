```r
library(dplyr)

df |>
  select(USUBJID, AVAL, AVALC)

df |>
  select(-TEMP)

df |>
  rename(AVAL = VALUE)
```

| R | SAS |
|---|---|
| `select(a, b)` | `KEEP a b;` (keep listed) |
| `select(-a)` | `DROP a;` |
| `rename(new = old)` | `RENAME old = new;` (note name order) |

Trap: SAS `RENAME old=new` puts the old name first. `dplyr::rename(new = old)` puts the new name first.
