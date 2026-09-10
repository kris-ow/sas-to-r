```r
# SAS: SUBSTR(string, start, length)
# R:   substr(string, start, stop)     stop is an end position, not a length

substr(usubjid, 5, 3)              # ""  (stop < start: empty range)
substr(usubjid, 5, 7)              # positions 5 through 7
substr(usubjid, 5, 5 + 3 - 1)      # SAS length 3, written as start+len-1

substring(usubjid, 5, 7)           # same idea; arguments recycle; can assign
# stringr::str_sub() also takes end positions, not a length
```

| R | SAS |
|---|---|
| `substr(x, start, stop)` | `SUBSTR(x, start, length)` |
| `substring(x, start, stop)` | `SUBSTR` with recycled bounds |
| `stringr::str_sub(x, start, end)` | `SUBSTR` (end, not length) |

Three traps: the third argument is a stop position, not a length. `substr(x, 5, 3)` is not "three characters from 5"; it is the empty range 5-to-3. Write `start+len-1`, or count the end position. `substring()` and `str_sub()` use end positions too.
