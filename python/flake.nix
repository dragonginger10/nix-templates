{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
  };

  outputs = {
    self,
    nixpkgs,
    poetry2nix,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
  in {
    formatters = pkgs.alejandra;
    devShells = forAllSystems (system: {
      default = pkgs.${system}.mkShellNoCC {
        packages = with pkgs.${system};
          [
            ruff
            black
            isort
            just
          ]
          ++ (with pkgs.${system}.python312Packages; [
            python-lsp-ruff
          ]);
      };
    });
  };
}
