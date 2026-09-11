```r
library(dplyr)

df |>
  mutate(
    AVAL = VALUE,
    AVALC = as.character(VALUE)
  )
```

| R | SAS |
|---|---|
| `mutate(NEW = expr)` | DATA step `new = expr;` |
| `mutate(VAR = expr)` | overwrite existing variable |
| several columns in one `mutate()` | several assignments in one DATA step |

Trap: `mutate()` returns a new table; assign it or pipe onward. It does not change the input object in place unless you overwrite the name.
