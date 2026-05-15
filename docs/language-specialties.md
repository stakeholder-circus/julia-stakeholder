# Julia Language Specialties

- The CLI is dependency-light and uses Julia standard libraries only.
- JSON is encoded by a small deterministic encoder so key order stays stable for normalized parity checks.
- Random selection uses a local stable LCG instead of Julia's default RNG, avoiding version-dependent stream drift.
- The package is terminal-first and works through `julia --project=. src/stakeholder.jl` on Linux, macOS, and Windows runners.
