{
  description =
    "Ready-made templates for easily creating flake-driven environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs }: let
    systems = ["x86_64-linux"];
    lib = import ./lib {inherit systems; lib = nixpkgs.lib;};
    inherit (lib.forAllSystems (pkgs: pkgs)) writeScriptBin mkShell;
    exec = lib.forAllSystems (pkgs: pkg: "${pkgs.${pkg}}/bin/${pkg}");

    dvt = writeScriptBin "dvt" ''
      if [ -z $1 ]; then
        echo "no template specified"
        exit 1
      fi

      TEMPLATE=$1

      ${exec "nix"} \
        --experimental-features 'nix-command flakes' \
        flake init \
        --template \
        "github:dragonginger10/nix-templates#''${TEMPLATE}"
    '';

    update = writeScriptBin "update" ''
      for dir in `ls -d */`; do # Iterate through all the templates
        (
          cd $dir
          ${exec "nix"} flake update # Update flake.lock
          ${exec "direnv"} reload    # Make sure things work after the update
        )
      done
    '';
  in
    {
      # templates = import ./templates.nix;
      formatter = lib.forAllSystems (pkgs: pkgs.alejandra);

      devShells = lib.forAllSystems (pkgs: 
        pkgs.mkShell {
          packages = with pkgs; [
          nil
          format
           update 
          ];
        });

      packages = rec {
        default = dvt;

        inherit dvt;
      };
    };
}
