{
  systems,
  nixpkgs,
}: let
  inherit (nixpkgs) lib;
  pkgsFor = lib.genAttrs systems (
    system:
      import nixpkgs {inherit system;}
  );
in
  f: lib.genAttrs systems (system: f pkgsFor.${system})
