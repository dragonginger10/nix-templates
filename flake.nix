{
  description = "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux"];
    forAllSystems = import ./lib/forallsystems.nix {inherit systems nixpkgs;};
    exec = f: pkg: "${f.${pkg}}/bin/${pkg}";
  in {
    templates = import ./templates.nix;
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    devShell = forAllSystems (pkgs: let
      update = pkgs.writeScriptBin "update" ''
        for dir in `ls -d */`; do # Iterate through all the templates
          (
            cd $dir
            ${exec pkgs "nix"} flake update # Update flake.lock
            ${exec pkgs "direnv"} reload    # Make sure things work after the update
          )
        done
      '';
    in
      pkgs.mkShell {
        packages = with pkgs; [
          nil
          update
        ];
      });

    packages = forAllSystems (pkgs: let
      dvt = pkgs.writeScriptBin "dvt" ''
        if [ -z $1 ]; then
          echo "no template specified"
          exit 1
        fi

        TEMPLATE=$1

        ${exec pkgs "nix"} \
          --experimental-features 'nix-command flakes' \
          flake init \
          --template \
          "github:dragonginger10/nix-templates#''${TEMPLATE}"
      '';
    in {
      inherit dvt;
      default = dvt;
    });
  };
}
