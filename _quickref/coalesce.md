```r
library(dplyr)

coalesce(x, y)                    # first non-NA argument; later args are fallbacks
coalesce(na_if(spy, ""), coded)   # specify, then coded. blanks are not NA

na_if(x, "")                      # "" -> NA so coalesce will skip it
na_if(x, "NA")                    # the literal string "NA" is not missing either
```

| R | SAS |
|---|---|
| `dplyr::coalesce()` | `COALESCE` (numeric), `coalescec` (character) |
| `na_if(x, "")` | SAS already treats blank as missing |
| `if_else(cond, a, b)` | `IFN` / `IFC` |

Three traps: `coalesce()` skips `NA` only, not `""`. A specify field of `""` therefore beats the coded value. Convert blanks with `na_if()` first, then prefer specify over coded:
`coalesce(na_if(spy, ""), coded)`.
