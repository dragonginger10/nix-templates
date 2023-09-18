{
  description = "A Nix-flake-based Dhall development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };

      # Helper function for building dhall-* tools
      mkDhallTools = ls:
        builtins.map (tool: pkgs.haskellPackages."dhall-${tool}") ls;

      dhallTools = mkDhallTools [
        "bash"
        "docs"
        "json"
        "lsp-server"
        "nix"
        "nixpkgs"
        "openapi"
        "toml"
        "yaml"
      ] ++ pkgs.lib.optionals (pkgs.stdenv.isLinux) (mkDhallTools [ "csv" "text" ]); # Linux only
    in
    {
      devShells.default = pkgs.mkShell {
        packages = (with pkgs; [ dhall ]) ++ dhallTools;

        shellHook = ''
          echo "dhall `${pkgs.dhall}/bin/dhall --version`"
        '';
      };
    });
}
