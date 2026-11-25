{self', pkgs}: {
  python = pkgs.python315.withPackages (p: with p;[
    typer
  ]);

}
