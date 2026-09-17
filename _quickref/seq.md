```r
library(dplyr)

df |>
  arrange(USUBJID, TUEVAL, TULNKID, VISITNUM, TUDY) |>  # order first
  group_by(USUBJID) |>
  mutate(SEQ = as.double(row_number())) |>              # --SEQ; double for SAS compares
  ungroup()
```

| R | SAS |
|---|---|
| `arrange(...)` then `group_by(USUBJID)` then `row_number()` | `PROC SORT` then `if first.usubjid then seq = 0; seq + 1;` |
| `group_by(USUBJID)` | `BY USUBJID` |
| `as.double(row_number())` | SAS numeric is double |

Traps: `row_number()` follows the current row order, so skip `arrange()` and `--SEQ` is whatever the last PROC left behind. Equal dates need tie-breakers in `arrange()`. `_N_` is not a within-`BY` counter. Cast to double so waldo/diffdf match SAS numeric; XPT has no separate integer type.
