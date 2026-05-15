# Julia Example Outputs

## List values
```bash
julia --project=. src/Stakeholder.jl --list-values
```

## Dedicated classic-six JSON
```bash
julia --project=. src/Stakeholder.jl --output-format json --seed 42 --focus-family code-analyzer
```

## Dedicated modern-core text
```bash
julia --project=. src/Stakeholder.jl --focus-family agent-workflows --jargon extreme
```

## Grouped fallback
```bash
julia --project=. src/Stakeholder.jl --output-format json --seed 7 --focus-family mcp-a2a-ops
```
