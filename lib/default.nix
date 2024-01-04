{systems, nixpkgs}: rec
{
  lib = nixpkgs.lib;
  pkgsFor = lib.genAttrs systems (system:
    import nixpkgs { inherit system; }
  );
  forAllSystems = f: lib.genAttrs systems (system: f pkgsFor.${system});
}
