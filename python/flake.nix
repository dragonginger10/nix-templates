{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    flake-parts = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject-nix";
      inputs.nixpkgs.follows ="nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = ["x86-64_linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: {

        packages.default = let
          project = inputs.pyproject-nix.lib.project.loadPyproject { projectRoot = ./.; };
          python = pkgs.python3;
          attrs = project.renerers.buildPythonPackage { inherit python; };
        in python.pkgs.buildPythonPackage (attrs);

        devenv.shells.default = {
          # https://devenv.sh/reference/options/
          packages = with pkgs; [
            just
          ];

          languages.python = {
            enable = true;
            uv.enable = true;
          };
        };
      };
    };
}
