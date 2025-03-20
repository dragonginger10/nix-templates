{
  description = "A Nix-flake-based Nix development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    systems = ["x86_64-linux" "aarch64-linux"];
    pkgsFor = lib.genAttrs systems (system: import nixpkgs {inherit system;});
    forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    devShell = forAllSystems (pkgs:
      pkgs.mkShell {
        packages = with pkgs; [
          nil
          nix-update
        ];
      });
  };
}
