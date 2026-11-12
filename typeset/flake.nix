{
  description = "A nix template for Typst mark up language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    perSystem = {pkgs, self', ...}: {
      packages = {
        # local fonts found per project
        localFonts = pkgs.stdenvNoCC.mkDerivation {
          pname = "fonts";
          version = "0.1";
          src = ./fonts;

          installPhase = ''
            mkdir -p $out/share/fonts/truetype/
            cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
          '';
        };
        fontsConf = pkgs.makeFontsConf {
          fontDirectories = with pkgs; [
            nunito
            self'.packages.localFonts
          ];
        };
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          typst
          typstyle
          just
        ];
        shellHook = ''
          export FONTCONFIG_FILE="${self'.packages.fontsConf}"
        '';
      };
    };
  };
}
