default: fmt up

fmt:
  nix fmt

@up:
  update
  git commit -am "update all flakes"

# update stable release to number
version number:
  sed -ri 's/(release-)([0-9]+\.[0-9]+)/\1{{number}}/' */flake.nix
  git commit -am "update stable release to {{number}}"
