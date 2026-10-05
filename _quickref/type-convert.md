```r
library(dplyr)

as.character(num)                        # strip(put(num, best.))
as.numeric(chr)                          # input(chr, best.)
as.numeric(na_if(trimws(chr), ""))       # blank text is not NA until you convert it

sprintf("%03d", num)                     # put(num, z3.)

as.Date(iso)                             # input(iso, yymmdd10.) as an R Date
as.Date(sas_date, origin = "1960-01-01") # SAS date number -> Date
as.integer(r_date - as.Date("1960-01-01")) # Date -> SAS date number

as.POSIXct(txt, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
as.POSIXct(sas_dt, origin = "1960-01-01", tz = "UTC")

as.numeric(as.character(fac))            # labels, not factor codes
as.numeric(sub(",", ".", dec_comma, fixed = TRUE)) # one decimal comma, no thousands mark
```

| R | SAS |
|---|---|
| `as.character(x)` | `strip(put(x, best.))` |
| `as.numeric(x)` | `input(x, best.)` |
| `sprintf("%03d", x)` | `put(x, z3.)` |
| `as.Date(x)` | `input(x, yymmdd10.)` / `put(date, yymmdd10.)` |
| `as.Date(n, origin = "1960-01-01")` | `n` is already a SAS date |
| `as.POSIXct(n, origin = "1960-01-01", tz = "UTC")` | `n` is a SAS datetime (`E8601DT.`) |
| `as.numeric(sub(",", ".", x, fixed = TRUE))` | `input(x, commax.)` for a single decimal comma |

Traps: `as.numeric("001")` is `1`. Leading zeros do not survive a numeric. `""` and `" "` are not `NA`; `as.numeric()` of either is `NA` and does not warn. `as.numeric("1,25")` is `NA` and warns `NAs introduced by coercion`. `as.numeric()` does not read a decimal comma, and `OutDec` only changes printing. `as.Date(n)` with no `origin` counts from 1970-01-01, not from the SAS epoch 1960-01-01. `as.numeric()` on a factor returns the level code, not the label. `put(x, best.)` is `BEST12.` and can contain blanks; `as.character()` does not pad.
