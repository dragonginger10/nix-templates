set quiet

APP_NAME := "script"

alias b := build

default:
  @just --list

lint: check fmt

fmt:
    black .
    isort .
    nix fmt

check:
    ruff check .

run:
  python ./{{APP_NAME}}.py

nix:
  nix run .#

version number: lint
    sed -ri "s/(__version__ = )(.*)/\1'{{number}}'/" MaidEdit/__init__.py
    sed -ri "s/(version = )(.*)/\1'{{number}}'/" pyproject.toml
    sed -ri 's/(version = )(.*)/\1"{{number}}";/' flake.nix
    git commit -a -m "Version number updated to {{number}}"
    git tag -a "v{{number}}"
    git push --tags

build: lint
    python -m build

pkg: build
    python -m twine upload --repository forgejo dist/*

clean:
    rm -rf dist # removes the build directory
    rm -rf ./result # removes the nix result
    rm -rf **/__pycache__ # removes the pycache from running
    rm -rf *.egg-info # removes the egg-info from building

