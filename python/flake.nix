{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {self', pkgs, ...}:
      {
        packages = import ./.nix/packages.nix {inherit self' pkgs;};
        devShells.default = import ./.nix/shell.nix {inherit self' pkgs;};
      };
    };
}
