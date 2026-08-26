{
  description = "A report built with Pandoc, XeLaTex and a custom font";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { flake-parts, ... }: flake-parts.lib.mkFlake {
    perSystem = {pkgs, ... }: let
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
        mkShellNoCC {
          packages = [
            tex
            just
            fontconfig
          ];
          shellHook = ''
            export FONTCONFIG_FILE=${fonts}
          '';
        };
    };
  };
}
