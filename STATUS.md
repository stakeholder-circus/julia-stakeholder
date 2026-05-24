# julia-stakeholder Status

- Role: Tranche C deterministic-first Julia port
- Parity class: full-parity target with deterministic-first tranche scope
- State: native-validated local deterministic tranche
- Rewrite completeness: 46%
- Functionality completeness: 40%
- Branch: `main`
- Origin: `git@github.com:stakeholder-circus/julia-stakeholder.git`
- Upstream: `https://github.com/giacomo-b/rust-stakeholder`

## Completed in Tranche C
- Replaced the Rust scaffold with a Julia CLI runtime.
- Added deterministic normalized JSON output with same-seed stability.
- Added `--list-values`, `--focus-family`, `--output-format text|json`, `--seed`, and explicit `--experimental-provider` fail-fast behavior.
- Implemented dedicated classic-six and modern-core families.
- Added grouped fallback for later families.
- Updated native tests, validation script, CI workflows, Dockerfile, flake, docs, and traceability notes.

## Evidence
- `python3 scripts/validate_scaffold.py`
- Julia `Pkg.test()` via scaffold validation
- `julia --project=. src/Stakeholder.jl --list-values`
- same-seed deterministic JSON diff for `platform-engineering`
- explicit `--experimental-provider local-demo` fail-fast smoke

## Remaining
- Live provider runtime remains deferred and fail-fast.
- Later families need dedicated renderer depth in a follow-on tranche.
- Cross-repo parity fixture comparison remains a stakeholder-core integration task.

## Canonical references
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/index.md`
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/next-20-wave.md`
