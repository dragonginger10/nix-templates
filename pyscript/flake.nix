{
  description = "A Nix-flake-based Python script development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
    pname = "script";
    version = "1.0";
  in {
    formatter = forEachSystem ({pkgs}: pkgs.alejandra);
    packages = forEachSystem ({pkgs}: rec {
      default = script;
      script = pkgs.stdenv.mkDerivation {
        inherit pname version;

        propagatedBuildInputs = [
          (pkgs.python311.withPackages (ps:
            with ps; [
              rich
            ]))
        ];

        dontUnpack = ":";
        installPhase = "install -Dm755 ${./${pname}.py} $out/bin/${pname}";
      };
    });

    devShells = forEachSystem ({pkgs}: {
      default = pkgs.mkShell {
        # pulls from build inputs of packages
        packages = with pkgs;
          [virtualenv black isort]
          ++ (with pkgs.python311Packages; [pip python-lsp-ruff])
          ++ (self.packages.${pkgs.system}.default.propagatedBuildInputs);

        shellHook = ''
          ${pkgs.python311}/bin/python --version
        '';
      };
    });
  };
}
