```r
library(dplyr)

as.character(num)                        # strip(put(num, best.))
as.numeric(chr)                          # input(chr, best.)
as.numeric(na_if(trimws(chr), ""))       # blank text is not NA until you convert it

sprintf("%03d", num)                     # put(num, z3.); integer only; NA -> " NA"

as.Date(iso)                             # input(iso, yymmdd10.) as an R Date
as.character(as.Date(iso))               # put(date, yymmdd10.)
format(as.Date(iso), "%Y-%m-%d")         # same character date
as.Date(sas_date, origin = "1960-01-01") # SAS date number -> Date
as.integer(r_date - as.Date("1960-01-01")) # Date -> SAS date number

as.POSIXct(txt, tz = "UTC")              # date only; time after T is dropped
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
| `as.Date(x)` | `input(x, yymmdd10.)` |
| `as.character(d)` / `format(d, "%Y-%m-%d")` | `put(date, yymmdd10.)` |
| `as.Date(n, origin = "1960-01-01")` | `n` is already a SAS date |
| `as.POSIXct(n, origin = "1960-01-01", tz = "UTC")` | `n` is a SAS datetime (`E8601DT.`) |
| `as.numeric(sub(",", ".", x, fixed = TRUE))` | `input(x, commax.)` for a single decimal comma |

Traps: `as.numeric("001")` is `1`. Leading zeros do not survive a numeric. `""` and `" "` are not `NA`; `as.numeric()` of either is `NA` and does not warn. `as.numeric("1,25")` is `NA` and warns `NAs introduced by coercion`. `as.numeric()` does not read a decimal comma, and `OutDec` only changes printing. `as.Date(n)` with no `origin` counts from 1970-01-01, not from the SAS epoch 1960-01-01. `as.Date()` reads; `put(date, yymmdd10.)` is `as.character(d)` or `format(d, "%Y-%m-%d")`. `as.numeric()` on a factor returns the level code, not the label. `put(x, best.)` is `BEST12.` and can contain blanks; `as.character()` does not pad. `sprintf("%03d", x)` needs an integer. `NA` becomes `" NA"`. A non-integer numeric errors. `as.POSIXct("2025-06-03T14:30:00", tz = "UTC")` with no `format` does not error: the date parses and the time is dropped (`2025-06-03 UTC`). Pass `format` to keep the clock time.
