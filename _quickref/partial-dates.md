```r
library(dplyr)
library(lubridate)

# year-only "2025" -> first / mid / last day of year
ymd(paste0(year_txt, "-01-01"))
ymd(paste0(year_txt, "-06-30"))   # common mid-year convention
ymd(paste0(year_txt, "-12-31"))

# year-month "2024-04" -> first / mid / last day of month
ymd(paste0(ym_txt, "-01"))
ymd(paste0(ym_txt, "-15"))        # common mid-month convention
(ceiling_date(ymd(paste0(ym_txt, "-01")), "month") - days(1)) |> as.Date()

# AE start: only when known year-month equals first dose and first-of-month
# is still before dose, set ASTDT to RFXSTDT; otherwise keep first-of-period
# year-only partials: compare format(..., "%Y") instead of "%Y-%m"
ASTDT <- ymd(paste0(AESTDTC, "-01"))
if_else(
  format(ASTDT, "%Y-%m") == format(RFXSTDT, "%Y-%m") & ASTDT < RFXSTDT,
  RFXSTDT,
  ASTDT
)
```

| R (after parsing the known part) | SAS idea |
|---|---|
| first day of month/year | impute to period start (`INTNX` beginning) |
| mid day (often 15 / 30 Jun) | sponsor mid-point rule |
| last day of month/year | impute to period end (`INTNX` end) |

Traps: document the mid rule (15 vs true midpoint). `ceiling_date(..., "month")` alone is next month start, not month end. Missing completely stays missing. Imputation flags (`ASTDTF`, `ADTF`) are ADaM; SDTM keeps partial `--DTC`. Impute AE start to first dose only when the known year-month matches first dose and first-of-period is still before dose (year-only partials compare on `"%Y"`). Do not clamp every earlier month onto the dose date. The exact rule, including AE end-date checks, comes from the SAP.
