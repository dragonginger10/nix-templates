{
  description = "A nix template for Typst mark up language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    perSystem = {pkgs, ...}: {
      devShells.default =  import ./.nix/shell.nix { inherit pkgs; };
      packages =  import ./.nix/package.nix { inherit pkgs; };
    };
  };
}
