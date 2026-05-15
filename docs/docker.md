# Julia Docker

## Build and smoke
```bash
docker build -t julia-stakeholder .
docker run --rm julia-stakeholder --list-values
docker run --rm julia-stakeholder --output-format json --seed 42 --focus-family code-analyzer
```

The image runs native Julia tests during build, then packages the CLI with `src/Stakeholder.jl` as the entrypoint.
