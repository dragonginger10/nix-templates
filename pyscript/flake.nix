{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };


  outputs = {
    self,
    nixpkgs,
  }:
    let
      supportedSystems = ["x86_64-linux" "aarch64-linux"];
      forEachSystem =f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
      pname = "script";
      version = "1.0";
    in {
      formatter = forEachSystem({ pkgs }: pkgs.alejandra);
      packages = forEachSystem({pkgs}: rec {
        default = errgen;
        errgen = pkgs.stdenv.mkDerivation {
          inherit pname version;

          propagatedBuildInputs = [
            (pkgs.python311.withPackages (ps:
              with ps; [
                click
            ]))
          ];

          dontUnpack = ":";
          installPhase = "install -Dm755 ${./${pname}.py} $out/bin/${pname}";
        };
      });

      devShells.default = forEachSystem({pkgs}: pkgs.mkShell {
        packages = with pkgs;
          [python311 virtualenv black isort]
          ++ (with pkgs.python311Packages; [pip python-lsp-ruff]);

        shellHook = ''
          ${pkgs.python}/bin/python --version
        '';
      });
    };
}
