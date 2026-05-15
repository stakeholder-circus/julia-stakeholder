# First-push families for julia-stakeholder

| Family | Source anchor | Java audit signal | Julia target | Parity class | Status |
| --- | --- | --- | --- | --- | --- |
| `code_analyzer` | `rust-stakeholder/src/generators/code_analyzer.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `data_processing` | `rust-stakeholder/src/generators/data_processing.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `jargon` | `rust-stakeholder/src/generators/jargon.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `metrics` | `rust-stakeholder/src/generators/metrics.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `network_activity` | `rust-stakeholder/src/generators/network_activity.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `system_monitoring` | `rust-stakeholder/src/generators/system_monitoring.rs`, `src/generators/common.rs` | Java closed `classic-six-depth-pending` | `src/stakeholder.jl` | `classic_six_dedicated` | implemented |
| `agent_workflows` | `rust-stakeholder/src/generators/agent_workflows.rs`, `src/generators/common.rs` | Java closed `modern-core-depth-pending` | `src/stakeholder.jl` | `modern_core_dedicated` | implemented |
| `platform_engineering` | `rust-stakeholder/src/generators/platform_engineering.rs`, `src/generators/common.rs` | Java closed `modern-core-depth-pending` | `src/stakeholder.jl` | `modern_core_dedicated` | implemented |
| `observability_ai_runtime` | `rust-stakeholder/src/generators/observability_ai_runtime.rs`, `src/generators/common.rs` | Java closed `modern-core-depth-pending` | `src/stakeholder.jl` | `modern_core_dedicated` | implemented |
| `delivery_preview_ops` | `rust-stakeholder/src/generators/delivery_preview_ops.rs`, `src/generators/common.rs` | Java closed `modern-core-depth-pending` | `src/stakeholder.jl` | `modern_core_dedicated` | implemented |
| `supply_chain_security` | `rust-stakeholder/src/generators/supply_chain_security.rs`, `src/generators/common.rs` | Java closed `modern-core-depth-pending` | `src/stakeholder.jl` | `modern_core_dedicated` | implemented |
| later families | `rust-stakeholder/src/domain.rs`, `src/generators/common.rs` | Java closed later-family depth rows | `src/stakeholder.jl` | `grouped_fallback` | deferred dedicated depth; explicit fallback |
| experimental provider | `rust-stakeholder/src/experimental.rs` | Java provider runtime is opt-in with remaining gaps | `src/stakeholder.jl` | intentional fail-fast | deferred in `GAPS.md` |
