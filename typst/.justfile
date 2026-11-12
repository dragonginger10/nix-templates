buildfolder := "./result"
output := "{{buildfolder}}/main.pdf"
srcfile := "main.typ"

build:
  nix run .#

clean:
  rm -rf {{buildfolder}}
  rm -f *.pdf
