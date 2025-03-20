default: fmt up

fmt:
  nix fmt

up:
  nix build

version number:
  sed -ris 's/(release-)([0-9]+\.[0-9]+)/\1{{number}}/' */flake.nix
