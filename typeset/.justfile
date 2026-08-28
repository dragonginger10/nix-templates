buildfolder := "./build"
srcfile := "main"
output := buildfolder / srcfile + ".pdf"

build: buildoutput
  typst compile ./{{srcfile}}.typ {{output}}

buildoutput:
  mkdir -p {{buildfolder}}

clean:
  rm -rf {{buildfolder}}
  rm -f *.pdf
