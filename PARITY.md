# Julia Parity

Rust remains the canonical behavioral source, Java is the first substantial follower port, and this repo now implements the Julia Tranche C deterministic-first slice.

## Implemented parity
- CLI accepts the rewrite contract's deterministic flags and preserves the Rust-style enum vocabulary.
- JSON output is normalized, stable, newline-terminated, and independent of wall clock time.
- Identical `--seed`, `--output-format json`, and `--focus-family` inputs produce byte-identical output.
- Classic-six and modern-core families have dedicated messages and parity classifications.

## Intentional normalized differences
- Julia emits one deterministic activity plan per invocation rather than an animated long-running terminal loop.
- `--duration`, `--alerts`, `--minimal`, and `--team` are parsed for contract compatibility but do not add timing-dependent behavior in Tranche C.
- ANSI styling is omitted from deterministic output.

## Promotion prerequisites remaining
- Native and Docker validation green on the target platform.
- Dedicated later-family renderers beyond grouped fallback.
- Cross-repo fixture comparison through `stakeholder-core`.
