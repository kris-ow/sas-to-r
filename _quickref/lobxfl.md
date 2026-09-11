```r
library(dplyr)

last_before <- tu |>
  filter(!is.na(TUDTC), !is.na(RFSTDTC), TUDTC <= RFSTDTC) |>
  group_by(USUBJID, TULNKID) |>
  slice_max(TUDTC, n = 1, with_ties = TRUE) |>
  ungroup() |>
  distinct(USUBJID, TULNKID, TUDTC) |>
  mutate(TULOBXFL = "Y")

tu |>
  left_join(last_before, by = c("USUBJID", "TULNKID", "TUDTC")) |>
  mutate(TULOBXFL = coalesce(TULOBXFL, ""))
```

| R | SAS |
|---|---|
| `filter(TUDTC <= RFSTDTC)` | subset on or before `RFSTDTC` |
| `slice_max(TUDTC, n = 1, with_ties = TRUE)` | last date in that subset |
| `left_join(...)` then `coalesce(..., "")` | merge a `"Y"` flag; blank otherwise |

Three traps: group by the entity (`TULNKID`), not only the subject. An empty qualifying set stays blank, not `"Y"` and not `NA`. `with_ties = TRUE` flags every row that shares the last date; `distinct()` on the flag keys so the join does not multiply rows. SDTM wants `""`, not `NA`.
