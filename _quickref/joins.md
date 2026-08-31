```r
library(dplyr)

# --- the six joins ------------------------------------------------------
inner_join(dm, ae, by = "subjid")   # rows matching on BOTH sides
left_join( dm, ae, by = "subjid")   # all of dm, annotated from ae   <- the usual one
right_join(dm, ae, by = "subjid")   # all of ae (just swap the args instead)
full_join( dm, ae, by = "subjid")   # everything from either side
anti_join( dm, ae, by = "subjid")   # in dm, NOT in ae               <- "who is missing?"
semi_join( dm, ae, by = "subjid")   # filter dm to matches, add no columns

# --- keys ---------------------------------------------------------------
left_join(dm, ae, by = c("subjid" = "SUBJID"))   # different names, left first
left_join(lb, visits, by = c("subjid", "visit")) # both keys must match

# --- state what you expect; the join aborts if the data disagrees -------
left_join(dm, ae, by = "subjid", relationship = "one-to-many")
# "one-to-one" | "one-to-many" | "many-to-one" | "many-to-many"
```

| R | SAS `DATA` step | SQL |
|---|---|---|
| `inner_join()` | `if a and b;` | `INNER JOIN` |
| `left_join()` | `if a;` | `LEFT JOIN` |
| `right_join()` | `if b;` | `RIGHT JOIN` |
| `full_join()` | no subsetting `if` | `FULL JOIN` |
| `anti_join()` | `if a and not b;` | `WHERE ... NOT IN` |
| `semi_join()` | `if a and b;` then dedupe | `WHERE EXISTS` |

Three traps: `NA` after a join means "no match", not "missing value". `inner_join()`
throws away your data errors and your event-free subjects together, without saying so.
And a duplicate key on the right silently multiplies rows, which is what
`relationship =` is for.
