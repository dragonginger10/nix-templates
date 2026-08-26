{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}: flake-parts.lib.mkFlake {
    perSystem = {pkgs, ...}: {
      formatter = pkgs.alejandra;
      devShell = pkgs.mkShellNoCC {
          packages = with pkgs; [
            nil
            statix
          ];
        };
    };

    flake = {
      nixosConfigurations.container = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./container.nix
        ];
      };
    };
  };
}
