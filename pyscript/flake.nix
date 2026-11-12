{
  description = "A Nix-flake-based Python script development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { flake-parts,... }: flake-parts.lib.mkFlake {
    systems = ["x86_64-linux" "aarch64-linux"];

    perSystem = {self', pkgs, ...}: {
      formatter = pkgs.alejandra;

      packages =  let
        pname = "script";
        version = "1.0";
      in rec {
        default = script;
        script = pkgs.stdenv.mkDerivation {
          inherit pname version;

          propagatedBuildInputs = [
            (pkgs.python312.withPackages (ps:
              with ps; [
                rich
                loguru
              ]))
          ];

          dontUnpack = ":";
          installPhase = "install -Dm755 ${./${pname}.py} $out/bin/${pname}";
        };
      };

    devShells.default = pkgs.mkShellNoCC {
        # pulls from build inputs of packages
        packages = with pkgs; [
            python314
            ruff
            black
            isort
            just
          ]
          ++ (with pkgs.python314Packages; [
            pip
          ])
          ++ self'.packages.default.propagatedBuildInputs;

        shellHook = ''
          ${pkgs.python314}/bin/python --version
        '';
      };
    };
  };
}
