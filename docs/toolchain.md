# Julia Toolchain

- State: Tranche C deterministic-first runtime
- Minimum Julia: 1.10
- Preferred local install: `brew install julia`

## Native commands
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
python3 scripts/validate_scaffold.py
julia --project=. src/Stakeholder.jl --list-values
julia --project=. src/Stakeholder.jl --output-format json --seed 42 --focus-family code-analyzer
```

## Nix commands
```bash
nix flake check
nix run .#check
nix run .#julia-stakeholder -- --list-values
```

## Docker commands
```bash
docker build -t julia-stakeholder .
docker run --rm julia-stakeholder --list-values
```
