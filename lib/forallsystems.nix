{systems, nixpkgs}: let
  lib = import <nixpkgs> {}.lib;
  pkgsFor = lib.genAttrs systems (
    system:
      import nixpkgs {inherit system;}
  );
in
f: lib.genAttrs systems (system: f pkgsFor.${system})
