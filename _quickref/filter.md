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

Trap: `filter()` keeps rows where the condition is `TRUE`. Rows with `NA` in the condition are dropped. SAS `where` also treats missing as not true for most comparisons.
