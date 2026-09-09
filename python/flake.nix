{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    flake-parts = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86-64_linux" "aarch64-linux"];

      perSystem = {pkgs, ...}: let
        python = pkgs.python3.withPackages (p: with p;[]);
      in {
        devShells.default = {
          packages = with pkgs; [
            just
            python
          ];
        };
      };
    };
}
