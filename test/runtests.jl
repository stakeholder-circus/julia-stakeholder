using Test

repo = dirname(@__DIR__)
cli = joinpath(repo, "src", "Stakeholder.jl")

function run_cli(args...)
    cmd = Cmd(vcat(Base.julia_cmd().exec, ["--project=", cli], collect(args)))
    out = Pipe()
    err = Pipe()
    proc = run(pipeline(ignorestatus(cmd), stdout=out, stderr=err), wait=false)
    close(out.in)
    close(err.in)
    stdout_text = read(out, String)
    stderr_text = read(err, String)
    wait(proc)
    return proc.exitcode, stdout_text, stderr_text
end

@testset "CLI contract" begin
    code, out, err = run_cli("--list-values")
    @test code == 0
    @test occursin("code-analyzer", out)
    @test occursin("agent-workflows", out)
    @test occursin("output-formats: text, json", out)
    @test isempty(err)

    code, out, err = run_cli("--output-format", "json", "--seed", "42", "--focus-family", "code-analyzer")
    @test code == 0
    @test occursin("\"family\":\"code_analyzer\"", out)
    @test occursin("\"sequence\":1", out)
    @test isempty(err)

    code, out, err = run_cli("--output-format", "json", "--seed", "42", "--focus-family", "code_analyzer")
    @test code == 0
    @test occursin("\"family\":\"code_analyzer\"", out)
    @test isempty(err)

    code2, out2, _ = run_cli("--output-format", "json", "--seed", "42", "--focus-family", "code-analyzer")
    @test code2 == 0
    @test out == out2

    code, out, err = run_cli("--output-format", "json", "--seed", "7", "--focus-family", "mcp-a2a-ops")
    @test code == 0
    @test occursin("\"parityClass\":\"grouped_fallback\"", out)
    @test occursin("\"family\":\"mcp_a2a_ops\"", out)

    code, out, err = run_cli("--experimental-provider", "local-demo")
    @test code != 0
    @test isempty(out)
    @test occursin("experimental provider runtime is not implemented", err)
end
