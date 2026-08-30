using JET
using Stakeholder
using Test

@testset "JET representative CLI analysis" begin
    JET.@test_call target_modules = (Stakeholder,) Stakeholder.main(String["--list-values"])
    JET.@test_call target_modules = (Stakeholder,) Stakeholder.main(
        String["--output-format", "json", "--seed", "42", "--focus-family", "code-analyzer"],
    )
    JET.@test_call target_modules = (Stakeholder,) Stakeholder.main(
        String["--experimental-provider", "local-demo"],
    )
end
