buildfolder := "./build"
output := "{{buildfolder}}/main.pdf"
srcfile := "main.typ"

build: buildoutput
  typst compile ./{{srcfile}} {{output}}

buildoutput:
  mkdir -p {{buildfolder}}

clean:
  rm -rf {{buildfolder}}
  rm -f *.pdf
