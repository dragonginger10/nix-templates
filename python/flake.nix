{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.05";
  };

  outputs = {
    self,
    nixpkgs
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
            uv
            just
          ]
          ++ (with pkgs.${system}.python312Packages; [
            python-lsp-ruff
          ]);
      };
    });
  };
}
