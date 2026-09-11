```r
library(dplyr)

# CDISC --DY has no day 0. The reference date is day 1, not day 0.
if_else(date < rfstdt, date - rfstdt, date - rfstdt + 1)

# same rule, no branch:
as.integer(date - rfstdt) + as.integer(date >= rfstdt)
```

| R | SAS |
|---|---|
| `date - rfstdt` | date minus date (raw, includes day 0) |
| `if_else(date < rfstdt, date - rfstdt, date - rfstdt + 1)` | `--DY` (no day 0) |
| `as.integer(date - rfstdt) + as.integer(date >= rfstdt)` | the same `--DY` rule, compact |

Three traps: raw subtraction is not `--DY`. On the reference date the raw diff is 0; `--DY` is 1. Dates before the reference stay negative and do not shift. Missing either date must stay missing, not become day 0.
