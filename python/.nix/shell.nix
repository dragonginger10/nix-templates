{self', pkgs}: pkgs.mkShell {
  packages = with pkgs; [
    just
    self'.packages.python
  ];
}
