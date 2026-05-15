# Julia Edge Cases

- Same seed plus same focused family produces byte-identical JSON.
- Empty `--framework ""` is allowed and omitted from JSON context.
- Unknown flags, invalid enum values, invalid families, and negative duration fail with exit code 2.
- `--experimental-provider` always fails fast in Tranche C and is recorded in `GAPS.md`.
- Later families are explicit grouped fallback, not silent placeholders.
- Tranche C avoids timing-dependent assertions by emitting deterministic one-shot plans.
