{
  description = "A nix template for Typst mark up language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... }: flake-parts.lib.mkFlake {
    perSystem = {pkgs, ...}: {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          typst
          typst-fmt
          just
        ];
      };
    };
  };
}
