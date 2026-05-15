{
  description = "julia-stakeholder deterministic-first Julia CLI";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: builtins.listToAttrs (map (system: { name = system; value = f system; }) systems);
    in {
      packages = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          julia-stakeholder = pkgs.writeShellApplication {
            name = "julia-stakeholder";
            runtimeInputs = [ pkgs.julia ];
            text = ''
              exec julia --project=${self} ${self}/src/Stakeholder.jl "$@"
            '';
          };
          check = pkgs.writeShellApplication {
            name = "check";
            runtimeInputs = [ pkgs.julia pkgs.python3 ];
            text = ''
              cd ${self}
              python3 scripts/validate_scaffold.py
            '';
          };
          default = self.packages.${system}.julia-stakeholder;
        });
      apps = forAllSystems (system: {
        julia-stakeholder = { type = "app"; program = "${self.packages.${system}.julia-stakeholder}/bin/julia-stakeholder"; };
        check = { type = "app"; program = "${self.packages.${system}.check}/bin/check"; };
        default = self.apps.${system}.julia-stakeholder;
      });
      checks = forAllSystems (system: {
        validate = self.packages.${system}.check;
      });
    };
}
