```r
toupper(x)                         # UPCASE
tolower(x)                         # LOWCASE
tools::toTitleCase(tolower(x))     # stand-in for PROPCASE; not equal to it
```

| R | SAS |
|---|---|
| `toupper(x)` | `UPCASE(x)` |
| `tolower(x)` | `LOWCASE(x)` |
| `tools::toTitleCase(tolower(x))` | `PROPCASE(x)` for plain words only |

Traps: `tools::toTitleCase()` is not `PROPCASE`. `PROPCASE` capitalizes every word, including `of`. `toTitleCase()` leaves English function words lowercase, and it does not treat `.` as a word break (`N.C.` becomes `N.c.` after `tolower()`). An all-caps word is left unchanged unless you `tolower()` first. `toupper()` on a factor returns character, not a factor. `toupper(NA)` is `NA`. `""` stays `""`.
