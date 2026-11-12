set shell := ["bash", "-c"]
script := "script.py"

init-script:
  uv python install
  uv init

init-package:
  uv python install
  uv init --package

run:
  uv run {{script}}

fmt:
  uvx black
  uvx isort .

bump:
  uv version --bump minor
