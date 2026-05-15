# Contributing to julia-stakeholder

## Rules
- Treat Rust as the source-of-truth baseline and Java as the first substantial follower audit signal.
- Use Conventional Commits.
- Do not land silent behavioral changes; update traceability and `GAPS.md` when behavior changes.
- Keep deterministic seeded JSON stable unless the change is explicitly documented as baseline evolution.
- Preserve the MIT license notice in [LICENSE](LICENSE).

## Local workflow
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
python3 scripts/validate_scaffold.py
docker build -t julia-stakeholder .
docker run --rm julia-stakeholder --list-values
```
