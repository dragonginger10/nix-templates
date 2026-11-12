{ self', pkgs }: rec {
  default = pdf;
  pdf = pkgs.stdenv.mkDerivationNoCC {
    name = "writable-gm-screen-inserts";
    src = ../.;
    nativeBuildInputs = with pkgs; [ typst ];
    buildPhase = ''
        export FONTCONFIG_FILE="${self'.packages.fontsConf}"
        typst *.typst
    '';
    installPhase = ''
        mkdir -p $out
        cp *.pdf $out
    '';
  };

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
}
