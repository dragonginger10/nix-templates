{
  description = "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts,... }: flake-parts.lib.mkFlake {inherit inputs;} {
    flake = {
      templates = import ./templates.nix;
    };

    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    perSystem = {lib, pkgs, ...}: {
      formatter = pkgs.alejandra;

      devShells.default = let
        update = pkgs.writeScriptBin "update" ''
          for dir in `ls -d */`; do # Iterate through all the templates
            (
              cd $dir
              ${lib.getExe pkgs.nix} flake update # Update flake.lock
              ${lib.getExe pkgs.direnv} reload    # Make sure things work after the update
            )
          done
        '';
      in pkgs.mkShell {
          shellHook = ''
            alias j = just
          '';
          packages = with pkgs; [
            nil
            just
            statix
            update
          ];
        };

      packages = let
        dvt = pkgs.writeScriptBin "dvt" ''
          if [ -z $1 ]; then
            echo "no template specified"
            exit 1
          fi

          TEMPLATE=$1

          ${lib.getExe pkgs.nix} \
            --experimental-features 'nix-command flakes' \
            flake init \
            --template \
            "github:dragonginger10/nix-templates#''${TEMPLATE}"
        '';
      in {
        inherit dvt;
        default = dvt;
      };

    };
  };
}
