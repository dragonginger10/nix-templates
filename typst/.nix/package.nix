{ self', pkgs }: rec {
  localFonts = pkgs.stdenvNoCC.mkDerivation {
      pname = "fonts";
      version = "0.1";
      src = ../fonts;

      installPhase = ''
        mkdir -p $out/share/fonts/truetype/
        cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
      '';
    };

  fontsConf = pkgs.makeFontsConf {
    fontDirectories = with pkgs; [
      nunito
    ];
  };
}
