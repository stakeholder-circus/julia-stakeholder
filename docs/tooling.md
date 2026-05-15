# Julia Tooling

## Commands
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
python3 scripts/validate_scaffold.py
julia --project=. src/Stakeholder.jl --output-format json --seed 42 --focus-family code-analyzer
```

## CI checks
- Native Julia tests on Ubuntu, macOS, and Windows.
- Validation script on Ubuntu.
- Docker smoke on Ubuntu.
- Actionlint and dependency-review workflows remain repository hygiene checks.
