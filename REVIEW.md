# Review checklist

Every pull request is checked against this list. The author (human or coding agent)
checks it before opening the PR; the reviewer checks it again on the diff.

## Workflow

1. One PR per topic, or per batch of related fixes. Small enough to read in one sitting.
2. PR description lists what changed and which checks were run.
3. Reviewer posts one review on the PR: **Must fix**, **Should fix**, **Minor**, each
   finding naming the file and quoting the line.
4. Author pushes fixes to the same branch and replies per finding (fixed, or why not).
5. Reviewer re-reviews only what changed since the last review.
6. Only the owner merges. Agents never merge.

Must fix blocks the merge. Should fix is expected unless the author gives a reason.
Minor is at the author's discretion.

## 1. SAS claims

A wrong SAS statement is the worst error this site can make: the reader knows SAS and
will trust the R side because the SAS side looked right.

- [ ] Every "SAS does X" claim is true in SAS 9.4 as written, not approximately.
- [ ] **Missing values.** SAS numeric missing is smaller than any number, so
      `where x < 100`, `if x < 100` and `ifn(x < 100, ...)` treat missing as true. R
      returns `NA`. Any comparison example states which side drops or keeps missing.
- [ ] SAS character missing is blank; R `""` is not `NA`. Stated wherever it changes
      the result.
- [ ] SAS equivalents are the idiomatic ones (`first.`/`last.`, `indsname=`, `INTNX`),
      not a construct that only looks similar (`_N_` is not a within-BY counter).
- [ ] The `.sas-equiv` block names the procedures, statements and functions a SAS
      programmer would search for.

## 2. CDISC claims

- [ ] The right standard is named: SDTM keeps data as collected; imputation, flags such
      as `ASTDTF`, and analysis derivations are ADaM.
- [ ] Variable names and reference dates match the IG (for example `--LOBXFL` uses
      `RFXSTDTC`, first exposure, not `RFSTDTC`).
- [ ] Sponsor or SAP conventions are labelled as such, never as "the IG says".
- [ ] Derivation rules are stated precisely enough that following them literally gives
      the right answer on edge cases. Check the example data covers those edge cases.
- [ ] `--DTC` variables are ISO 8601 character. An example that holds dates as `Date`
      uses a non-`DTC` name (`VSDT`) or shows the conversion.

## 3. R code

- [ ] Every worked example is an executed chunk and the preview build is green.
- [ ] The quick-reference block (static, not executed) matches the worked examples
      below it: same functions, same arguments, same rule.
- [ ] Current dplyr idiom (`.default` in `case_when()`, `|>`, `relationship =` on joins).
- [ ] Output shown or described in prose matches what the chunk actually prints.
- [ ] Example data uses generic `STD-001-*` subjects. Nothing from a real study.

## 4. Page structure

- [ ] Follows "Adding a topic" in `README.md`: quick reference first, include near the
      top, `.sas-equiv` block, `index.qmd`, `cheatsheet.qmd`, CI packages.
- [ ] Trap lines start with `Traps:`, never a count.
- [ ] Prose is short and declarative. No marketing, no personal content.

## 5. Mechanical

- [ ] `bash tools/check-ascii.sh` passes.
- [ ] New R packages added to both `publish.yml` and `pr-preview.yml`.
- [ ] Links between topics resolve on the preview site.
