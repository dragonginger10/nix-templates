{self', pkgs }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    typst
    typstyle
    just
  ];
  shellHook = ''
    export FONTCONFIG_FILE="${self'.packages.fontsConf}"
  '';
}
