module Stakeholder

export main

const DEV_TYPES = ["backend", "frontend", "fullstack", "data-science", "devops", "blockchain", "machine-learning", "systems-programming", "game-development", "security"]
const JARGON_LEVELS = ["low", "medium", "high", "extreme"]
const COMPLEXITIES = ["low", "medium", "high", "extreme"]
const OUTPUT_FORMATS = ["text", "json"]
const CLASSIC_SIX = ["code-analyzer", "data-processing", "jargon", "metrics", "network-activity", "system-monitoring"]
const MODERN_CORE = ["agent-workflows", "platform-engineering", "observability-ai-runtime", "delivery-preview-ops", "supply-chain-security"]
const LATER_FAMILIES = ["ai-inference-ops", "evaluation-and-guardrails", "knowledge-retrieval", "edge-client-runtime", "identity-and-trust", "aibom-provenance", "agent-boundary-security", "embedded-agentic-pipeline", "data-governance-compliance", "finops-capacity", "blockchain-protocol-ops", "cross-chain-interop", "proof-and-sequencer-ops", "hybrid-runtime-ops", "capacity-cost-controller", "batch-execution-tuner", "compiler-maintainer", "interop-adapter-engineer", "preflight-capacity-planner", "simulator-performance-engineer", "fhir-profile-generator", "smart-launch-oauth", "bulk-fhir-population-ops", "hl7v2-feed-ops", "clinical-workflow-events", "dicomweb-imaging-ops", "openehr-semantic-record-ops", "device-telemetry-clinical", "emr-vendor-adapter", "ocpp-chargepoint-ops", "ocpi-roaming-ops", "mcp-a2a-ops", "streaming-bus-ops", "service-mesh-rpc-ops"]
const ALL_FAMILIES = vcat(CLASSIC_SIX, MODERN_CORE, LATER_FAMILIES)
const ACTIVITY_COUNTS = Dict("low" => 1, "medium" => 2, "high" => 3, "extreme" => 4)

struct Config
    dev_type::String; jargon::String; complexity::String; duration::Int; alerts::Bool; project::String; minimal::Bool; team::Bool; framework::String; list_values::Bool; focus_family::Union{Nothing,String}; output_format::String; seed::Union{Nothing,UInt64}; experimental_provider::Union{Nothing,String}
end
mutable struct StableRng state::UInt64 end
next_u64!(r::StableRng)::UInt64 = (r.state = r.state * UInt64(6364136223846793005) + UInt64(1442695040888963407))
choose_stable!(r::StableRng, xs::Vector{String})::String = xs[Int(mod(next_u64!(r), UInt64(length(xs)))) + 1]
snake(s::String)::String = replace(s, "-" => "_")

function json_escape(s::AbstractString)::String
    io = IOBuffer()
    for c in s
        c == '"' ? print(io, "\\\"") : c == '\\' ? print(io, "\\\\") : c == '\n' ? print(io, "\\n") : c == '\r' ? print(io, "\\r") : c == '\t' ? print(io, "\\t") : print(io, c)
    end
    String(take!(io))
end
function to_json(v)::String
    v === nothing && return "null"
    v isa Bool && return v ? "true" : "false"
    v isa Integer && return string(v)
    v isa AbstractString && return "\"$(json_escape(v))\""
    v isa Vector && return "[" * join(map(to_json, v), ",") * "]"
    if v isa Dict
        ks = sort(collect(keys(v)))
        return "{" * join(["\"$(json_escape(String(k)))\":" * to_json(v[k]) for k in ks], ",") * "}"
    end
    error("unsupported json value: $(typeof(v))")
end

const DESCRIPTORS = Dict(
    "code-analyzer" => ("Code analyzer", "reviewing typed interfaces and SDK drift across the active service graph", "triaging monorepo dependency edges, generated patches, and schema compatibility before merge", "replaying agent-authored patchsets against contract drift, ownership boundaries, and MCP tool assumptions"),
    "data-processing" => ("Data processing", "refreshing embedding corpora, batch transforms, and event windows for the current dataset", "rebuilding hybrid retrieval indexes, semantic chunks, and NDJSON backfills for downstream consumers", "reconciling multimodal pipelines, lakehouse batch cuts, and evaluation-ready data slices under deterministic ordering"),
    "jargon" => ("Jargon refresh", "keeping technical language current without drifting into fake-deep jargon", "switching phrasing toward credible 2026 agent, platform, protocol, and security terminology", "enforcing modern domain vocabulary so advanced output stays precise instead of sounding synthetic"),
    "metrics" => ("Metrics", "tracking queue depth, latency bands, and cost signals across the active workload", "correlating token spend, SLO burn, GPU occupancy, and attestation coverage in one metrics lane", "folding evaluation score movement, blob economics, and runner pressure into a single operations dashboard"),
    "network-activity" => ("Network activity", "observing RPC, event-stream, and adapter traffic across the current service boundary", "mapping MCP calls, inference APIs, registry fetches, and cross-domain message flow under backpressure", "profiling mixed gRPC, Kafka, MQTT, and bridge traffic while preserving replay semantics and retry windows"),
    "system-monitoring" => ("System monitoring", "watching collector pressure, runner health, and process saturation on the active stack", "capturing GPU memory pressure, secret-scan spikes, sandbox failures, and scheduler queue churn", "stitching host telemetry, proof queues, provisioning lag, and policy denials into one operational heartbeat"),
    "agent-workflows" => ("Agent workflows", "routing coding-agent work through review queues and approval gates", "coordinating delegated patch runs, blocked tool calls, and human checkpoints across multiple repos", "orchestrating branch handoff envelopes, MCP leases, and merge-safe approval chains for background agents"),
    "platform-engineering" => ("Platform engineering", "maintaining golden paths, service templates, and workload identity for self-service delivery", "resolving platform policy denials, tenant quotas, and template drift inside the internal developer portal", "reconciling workload identity, cluster tenancy, policy bundles, and queue fairness across platform control planes"),
    "observability-ai-runtime" => ("Observability AI runtime", "recording traces, token spend, and latency bands for the active runtime", "tracking OTel collector saturation, span cardinality, and GPU telemetry alongside tool-call traces", "driving burn-rate analysis across inference queues, cost attribution, and distributed reasoning spans"),
    "delivery-preview-ops" => ("Delivery preview ops", "managing preview environments, feature flags, and canary promotions for current changes", "holding rollout gates on runner saturation, preview drift, and canary health regression signals", "sequencing flag freezes, rollback windows, and staged promotion rules across agent-authored delivery pipelines"),
    "supply-chain-security" => ("Supply-chain security", "checking artifact trust, secret exposure, and dependency health before release", "verifying provenance attestations, AIBOM coverage, revocation posture, and tamper signals across build lanes", "gating release promotion on signed artifacts, dependency substitution checks, and cross-tool trust evidence"),
)
const PROTOCOLS = Dict("network-activity" => "grpc", "agent-workflows" => "mcp", "supply-chain-security" => "provenance_check", "observability-ai-runtime" => "otel_runtime_event")

function parse_args(argv)::Config
    v = Dict{String,Any}("dev-type" => "backend", "jargon" => "medium", "complexity" => "medium", "duration" => 0, "alerts" => false, "project" => "distributed-cluster", "minimal" => false, "team" => false, "framework" => "", "list-values" => false, "focus-family" => nothing, "output-format" => "text", "seed" => nothing, "experimental-provider" => nothing)
    i = 1
    while i <= length(argv)
        a = argv[i]
        if a in ["--alerts", "--minimal", "--team", "--list-values"]
            v[a[3:end]] = true; i += 1
        elseif startswith(a, "--")
            name = a[3:end]
            name in keys(v) || error("unknown option --$name")
            i < length(argv) || error("missing value for --$name")
            v[name] = argv[i + 1]; i += 2
        else
            error("unexpected positional argument $a")
        end
    end
    for (name, allowed) in [("dev-type", DEV_TYPES), ("jargon", JARGON_LEVELS), ("complexity", COMPLEXITIES), ("output-format", OUTPUT_FORMATS)]
        v[name] in allowed || error("invalid --$name '$(v[name])'; expected one of $(join(allowed, ", "))")
    end
    v["focus-family"] = v["focus-family"] === nothing ? nothing : replace(v["focus-family"], "_" => "-")
    v["focus-family"] === nothing || v["focus-family"] in ALL_FAMILIES || error("invalid --focus-family '$(v["focus-family"])'; use --list-values for supported families")
    seed = v["seed"] === nothing ? nothing : parse(UInt64, v["seed"])
    duration = parse(Int, string(v["duration"])); duration >= 0 || error("--duration must be zero or greater")
    Config(v["dev-type"], v["jargon"], v["complexity"], duration, v["alerts"], v["project"], v["minimal"], v["team"], v["framework"], v["list-values"], v["focus-family"], v["output-format"], seed, v["experimental-provider"])
end

function message(family::String, jargon::String)::String
    if haskey(DESCRIPTORS, family)
        d = DESCRIPTORS[family]
        return jargon in ["low", "medium"] ? d[2] : jargon == "high" ? d[3] : d[4]
    end
    "running grouped fallback activity for $(replace(family, "-" => " ")) with deterministic normalized output until dedicated parity lands"
end
title_for(f::String)::String = haskey(DESCRIPTORS, f) ? DESCRIPTORS[f][1] : join(map(uppercasefirst, split(replace(f, "-" => " "), " ")), " ")
parity_class(f::String)::String = f in CLASSIC_SIX ? "classic_six_dedicated" : f in MODERN_CORE ? "modern_core_dedicated" : "grouped_fallback"

function plan_families(c::Config)::Vector{String}
    c.focus_family !== nothing && return [c.focus_family]
    rng = StableRng(c.seed === nothing ? UInt64(20260515) : c.seed)
    selected = String[]; pool = vcat(CLASSIC_SIX, MODERN_CORE)
    while length(selected) < ACTIVITY_COUNTS[c.complexity]
        f = choose_stable!(rng, pool); f in selected || push!(selected, f)
    end
    selected
end

function event_for(c::Config, f::String, seq::Int)::Dict{String,Any}
    ctx = Dict{String,Any}("complexity" => ACTIVITY_COUNTS[c.complexity], "devType" => snake(c.dev_type), "family" => f, "outputFormat" => c.output_format, "parityClass" => parity_class(f), "project" => c.project)
    c.framework != "" && (ctx["framework"] = c.framework)
    c.seed !== nothing && (ctx["seed"] = Int(c.seed))
    haskey(PROTOCOLS, f) && (ctx["protocolAdapter"] = PROTOCOLS[f])
    Dict{String,Any}("context" => ctx, "eventType" => "activity", "family" => snake(f), "flavors" => String[], "generationProvenance" => Dict{String,Any}("adapterType" => "static-catalog", "baseline" => "tranche-c-deterministic-first", "experimental" => false, "promptVersion" => nothing, "sourceRepo" => "rust-stakeholder"), "message" => message(f, c.jargon), "protocol" => get(PROTOCOLS, f, nothing), "schemaRef" => nothing, "sequence" => seq, "timestamp" => "T+" * lpad(string(seq * 137), 6, '0') * "ms")
end

function print_list_values()
    println("dev-types: " * join(DEV_TYPES, ", "))
    println("jargon: " * join(JARGON_LEVELS, ", "))
    println("complexity: " * join(COMPLEXITIES, ", "))
    println("output-formats: " * join(OUTPUT_FORMATS, ", "))
    println("classic-six: " * join(CLASSIC_SIX, ", "))
    println("modern-core: " * join(MODERN_CORE, ", "))
    println("later-families: " * join(LATER_FAMILIES, ", "))
    println("experimental-provider: fail-fast only in Tranche C")
end

function render_text(events)
    for e in events
        f = replace(e["family"], "_" => "-")
        println("[$(e["timestamp"])] $(title_for(f)): $(e["message"])")
    end
end

function main(argv=ARGS)::Int
    try
        c = parse_args(argv)
        if c.experimental_provider !== nothing
            println(stderr, "experimental provider runtime is not implemented in Julia Tranche C; requested provider '$(c.experimental_provider)' is deferred in GAPS.md")
            return 2
        end
        c.list_values && (print_list_values(); return 0)
        events = [event_for(c, f, seq) for (seq, f) in enumerate(plan_families(c))]
        c.output_format == "json" ? println(to_json(events)) : render_text(events)
        return 0
    catch exc
        println(stderr, "julia-stakeholder: " * sprint(showerror, exc)); return 2
    end
end

end

if abspath(PROGRAM_FILE) == @__FILE__
    exit(Stakeholder.main())
end
