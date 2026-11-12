buildfolder := "./output"
output := buildfolder / "output.pdf"
srcfile := "main.typ"

alias c := clean

build:
  mkdir -p {{buildfolder}}
  typst compile {{srcfile}} {{output}}

clean:
  rm -rf {{buildfolder}}
  rm -f *.pdf
