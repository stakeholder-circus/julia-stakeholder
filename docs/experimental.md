# Julia Experimental Surface

Experimental provider support is intentionally not active in Tranche C.

```bash
julia --project=. src/Stakeholder.jl --experimental-provider local-demo
```

The command exits non-zero and explains that live-provider runtime support is deferred. Deterministic JSON never depends on provider state, credentials, sessions, network access, or wall-clock time.
