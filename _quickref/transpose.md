```r
library(dplyr)
library(tidyr)

# long -> wide. PROC TRANSPOSE; by keys; id paramcd; var aval;
lb |>
  pivot_wider(names_from = PARAMCD, values_from = AVAL)

# wide -> long. NAME= is names_to; rename COL1 to the value column
wide |>
  pivot_longer(c(ALT, AST), names_to = "PARAMCD", values_to = "AVAL")

# LET keeps the last duplicate ID. Without values_fn, pivot_wider warns.
lb_dup |>
  pivot_wider(names_from = PARAMCD, values_from = AVAL, values_fn = last)

# SUPPAE onto AE. QVAL stays character. IDVARVAL is character; AESEQ is integer.
supp_wide <- suppae |>
  filter(RDOMAIN == "AE", IDVAR == "AESEQ") |>
  mutate(AESEQ = as.integer(IDVARVAL)) |>
  pivot_wider(
    id_cols = c(STUDYID, USUBJID, AESEQ),
    names_from = QNAM,
    values_from = QVAL
  )

ae |>
  left_join(
    supp_wide,
    by = c("STUDYID", "USUBJID", "AESEQ"),
    relationship = "one-to-one"
  )
```

| R | SAS |
|---|---|
| `pivot_wider(names_from, values_from)` | `PROC TRANSPOSE` with `BY`, `ID`, `VAR` |
| `names_prefix = "AVAL_"` | `PREFIX=AVAL_` when `ID` is set |
| `pivot_longer(cols, names_to, values_to)` | `PROC TRANSPOSE` with `VAR` and `NAME=`; values land in `COL1` |
| `values_fn = last` | `LET` (last duplicate `ID` in the `BY` group) |
| `left_join()` after the widen | `MERGE` / SQL `LEFT JOIN` of `SUPPxx` onto the parent |

Traps: `QVAL` stays character. `IDVARVAL` is character and `AESEQ` is numeric; the join does not match until those types agree. A blank `QVAL` stays `""`. A qualifier with no SUPP row is `NA` after `pivot_wider()`. In SAS both are character missing. A repeated `ID` in a `BY` group makes `PROC TRANSPOSE` error unless `LET` is set. `pivot_wider()` without `values_fn` warns and returns list-columns. `PROC TRANSPOSE` requires the `BY` variables to be sorted. `SUPPxx` is SDTM collected structure, not an ADaM imputation. A standard parent variable such as `AEDUR` is not a SUPP `QNAM`.
