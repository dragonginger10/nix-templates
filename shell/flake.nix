{
  description = "A nix flake shell dev environment";

  inputs = {
    nipkgs.url = "github:NixOS/nixpkgs/release-24.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs;
    systems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = f:
      genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [shellcheck];
      };
    });
  };
}
