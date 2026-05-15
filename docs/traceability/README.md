# Julia Traceability

Julia Tranche C ports the deterministic Rust baseline shape and follows the Java follower-port audit where Java already confirmed registry-backed deterministic runtime behavior.

Traceability rows must cite:
- Rust source file or enum family anchor.
- Java follower audit signal when useful.
- Julia target file.
- Parity class: `classic_six_dedicated`, `modern_core_dedicated`, or `grouped_fallback`.
- Gap entry for deferred or fail-fast behavior.
