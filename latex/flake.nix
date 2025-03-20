{
  description = "A report built with Pandoc, XeLaTex and a custom font";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      fonts = pkgs.makeFontsConf {fontDirectories = [pkgs.dejavu_fonts pkgs.dejavu_fontsEnv];};
      tex = pkgs.texlive.combine {
        inherit
          (pkgs.texlive)
          scheme-small
          latex-bin
          dejavu-otf
          dejavu
          glossaries
          mfirstuc
          xfor
          datatool
          adjustbox
          collectbox
          titlepic
          subfiles
          ;
      };
    in {
      devShells.default = with pkgs;
        mkShell {
          buildInputs = [
            tex
            fontconfig
          ];
          shellHook = ''
            export FONTCONFIG_FILE=${fonts}
          '';
        };
    });
}
