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
    lib = nixpkgs.lib;
    pkgsFor = lib.genAttrs systems (
      system:
        import nixpkgs {inherit system;}
    );
    forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in 
  forAllSystems (pkgs: 
  let
      exec = pkg: "${pkgs.${pkg}}/bin/${pkg}";
      update = pkgs.writeScriptBin "update" ''
        for dir in `ls -d */`; do # Iterate through all the templates
          (
            cd $dir
            ${exec "nix"} flake update # Update flake.lock
            ${exec "direnv"} reload    # Make sure things work after the update
          )
        done
      '';
      dvt = pkgs.writeScriptBin "dvt" ''
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
  in
  {
    templates = import ./templates.nix;
    formatter = pkgs.alejandra;

    devShell = pkgs.mkShell {
      packages = with pkgs; [
        nil
        update
      ];
    };
    packages = {
      inherit dvt;
      default = dvt;      
    };
  });
}
