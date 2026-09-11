```r
library(dplyr)

df |>
  mutate(
    AGEGR1 = if_else(AGE < 65L, "<65", ">=65")
  )

df |>
  mutate(
    AESEVN = case_when(
      AESEV == "MILD" ~ 1L,
      AESEV == "MODERATE" ~ 2L,
      AESEV == "SEVERE" ~ 3L,
      TRUE ~ NA_integer_
    )
  )
```

| R | SAS |
|---|---|
| `if_else(cond, true, false)` | `IFN` / `IFC`, or `if then ... else` |
| `case_when(cond ~ val, ...)` | `SELECT` / nested `IF-THEN-ELSE` |
| `case_when(..., TRUE ~ other)` | OTHERWISE / final else |

Trap: `dplyr::if_else()` is stricter on types than base `ifelse()`. Prefer `if_else()` in dplyr pipelines. `case_when()` stops at the first true condition.
