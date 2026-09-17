```r
library(dplyr)

df |>
  filter(PARAMCD == "SYSBP")

df |>
  filter(PARAMCD == "SYSBP", !is.na(AVAL))
```

| R | SAS |
|---|---|
| `filter(cond)` | `where cond;` or subsetting `if cond;` |
| `filter(a, b)` | `where a and b;` (both must be true) |
| `filter(a \| b)` | `where a or b;` |

Traps: `filter()` keeps rows where the condition is `TRUE`. `NA` in the condition drops the row. SAS `where aval < 100` keeps missing numeric rows (missing is smaller than any number). Use `!is.na(AVAL)` when missing must not pass.
