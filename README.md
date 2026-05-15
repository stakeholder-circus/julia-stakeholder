> [!WARNING]
> This repository is AI-assisted and manually reviewed. It is currently a local-only Julia deterministic parity target.

# julia-stakeholder

Julia Tranche C port of `rust-stakeholder` under stakeholder-circus.

## Status
- Deterministic-first Julia CLI is implemented.
- Default branch remains `main`; no upstream tracking is attached by this tranche.
- MIT license notice from the Rust source remains preserved in [LICENSE](LICENSE).

## Implemented command contract
```bash
julia --project=. src/Stakeholder.jl --list-values
julia --project=. src/Stakeholder.jl --output-format json --seed 42 --focus-family code-analyzer
julia --project=. src/Stakeholder.jl --focus-family agent-workflows --jargon extreme
```

Supported flags:
- `--list-values`
- `--focus-family <family>`
- `--output-format text|json`
- `--seed <integer>`
- `--experimental-provider <id>` fail-fast with a non-zero exit
- Rust contract flags retained for parity shape: `--dev-type`, `--jargon`, `--complexity`, `--duration`, `--alerts`, `--project`, `--minimal`, `--team`, `--framework`

## Family coverage
- Dedicated classic-six: `code-analyzer`, `data-processing`, `jargon`, `metrics`, `network-activity`, `system-monitoring`.
- Dedicated modern-core: `agent-workflows`, `platform-engineering`, `observability-ai-runtime`, `delivery-preview-ops`, `supply-chain-security`.
- Later families emit grouped fallback JSON with explicit `parityClass: grouped_fallback`.

## Validation
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
python3 scripts/validate_scaffold.py
docker build -t julia-stakeholder .
docker run --rm julia-stakeholder --list-values
```

## Documentation
- [STATUS.md](STATUS.md)
- [PARITY.md](PARITY.md)
- [GAPS.md](GAPS.md)
- [docs/toolchain.md](docs/toolchain.md)
- [docs/traceability/first-push-families.md](docs/traceability/first-push-families.md)
