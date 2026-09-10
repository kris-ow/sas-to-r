```r
library(dplyr)

df %>%
  arrange(USUBJID, TUEVAL, TULNKID, VISITNUM, TUDY) %>%  # order first
  group_by(USUBJID) %>%
  mutate(SEQ = as.double(row_number())) %>%              # --SEQ, XPT-shaped
  ungroup()
```

| R | SAS |
|---|---|
| `arrange(...)` then `row_number()` | `PROC SORT` then `_N_` within `BY` |
| `group_by(USUBJID)` | `BY USUBJID` |
| `as.double(row_number())` | SAS numeric is always double |

Three traps: `row_number()` follows the current row order, so skip `arrange()` and `--SEQ` is whatever the last PROC left behind. Equal dates need tie-breakers in `arrange()`. Integer `SEQ` is not how SAS XPT stores it; use `as.double()`.
