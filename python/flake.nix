{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    poetry2nix.url = "github:nix-community/poetry2nix";
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
    packages = forAllSystems (system: let
      inherit (poetry2nix.lib.mkPoetry2Nix {pkgs = pkgs.${system};}) mkPoetryApplication;
    in {
      default = mkPoetryApplication {projectDir = self;};
    });

    devShells = forAllSystems (system: let
      inherit (poetry2nix.lib.mkPoetry2Nix {pkgs = pkgs.${system};}) mkPoetryEnv;
    in {
      default = pkgs.${system}.mkShellNoCC {
        packages = with pkgs.${system};
          [
            (mkPoetryEnv {projectDir = self;})
            poetry
            ruff
            black
            isort
          ]
          ++ (with pkgs.${system}.python311Packages; [
            python-lsp-ruff
          ]);
      };
    });
  };
}
