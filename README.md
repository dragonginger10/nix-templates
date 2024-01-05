# Nix flake templates for easy dev environments

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

To initialize (where `${ENV}` is listed in the table below):

```shell
nix flake init --template github:the-nix-way/dev-templates#${ENV}
```

Here's an example (for the [`rust`](./rust) template):

```shell
# Initialize in the current project
nix flake init --template github:the-nix-way/dev-templates#rust

# Create a new project
nix flake new --template github:the-nix-way/dev-templates#rust ${NEW_PROJECT_DIRECTORY}
```

> **Note**: All templates are pinned to the [23.11 release][release] of Nixpkgs.

## How to use the templates

Once your preferred template has been initialized, you can use the provided shell in two ways:

1. If you have [`nix-direnv`][nix-direnv] installed, you can initialize the environment by running `direnv allow`.
2. If you don't have `nix-direnv` installed, you can run `nix develop` to open up the Nix-defined shell.

## Available templates

| Language/framework/tool  | Template                      |
| :----------------------- | :-----------------------------|
| [Elixir]                 | [`elixir`](./elixir/)         |
| [Go]                     | [`go`](./go/)                 |
| [Hashicorp] tools        | [`hashi`](./hashi/)           |
| [Haskell]                | [`haskel`](./haskel/)         |
| [Latex] tools            | [`latex`](./latex/)           |
| [Nix]                    | [`nix`](./nix/)               |
| [PHP]                    | [`php`](./php/)               |
| [Python]                 | [`python`](./python/)         |
| [Rust]                   | [`rust`](./rust/)             |
| [Typst] tools            | [`typst`](./typst/)           |
  
## Template contents

The sections below list what each template includes. In all cases, you're free to add and remove packages as you see fit; the templates are just boilerplate.


### [`elixir`](./elixir/)

- [Elixir] 1.13.4, including [mix] and [IEx]
- [gigalixir] (Linux only)

### [`go`](./go/)

- [Go] 1.19
- Standard Go tools ([goimports], [godoc], and others)
- [golangci-lint]

### [`hashi`](./hashi/)

- [Packer] 1.8.2
- [Terraform] 1.2.7
- [Nomad] 1.2.9
- [Vault] 1.11.2
- [nomad-autoscaler] 0.3.6-dev
- [nomad-pack] 0.0.1-techpreview.3
- [levant] 0.3.1-dev
- [damon]
- [Terragrunt] 0.37.0
- [tflint] 0.39.3

### [`haskell`](./haskell/)

- [GHC][haskell] 9.0.2
- [cabal] 3.6.2.0

### [`nix`](./nix/)

- [Cachix] 0.8.1
- [dhall-to-nix] 1.1.23
- [lorri]
- [niv]
- [nixfmt]
- [statix]
- [vulnix]

### [`php`](./php/)

- [PHP] 8.1.10
- [Composer] 2.4.2

### [`python`](./python/)

- [Python] 3.11.0rc1
- [pip] 22.1.2
- [Virtualenv] 20.15.1
- [mach-nix]

### [`rust`](./rust/)

- [Rust], including [cargo], [Clippy], and the other standard tools. The Rust version is determined as follows, in order:

  - From the `rust-toolchain.toml` file if present
  - From the `rust-toolchain` file if present
  - Version 1.63.0 if neither is present

- [rust-analyzer] 2022-08-01
- [cargo-audit] 0.17.0
- [cargo-deny] 0.12.1
- [cross] 0.2.4

## Code organization

All of the templates have only the root [flake](./flake.nix) as a flake input. That root flake provides a common revision of [Nixpkgs] and [`flake-utils`][flake-utils] to all the templates.

[ant]: https://ant.apache.org
[boot]: https://www.boot-clj.com
[buf]: https://github.com/bufbuild/buf
[cabal]: https://www.haskell.org/cabal
[cachix]: https://www.cachix.org
[cargo]: https://doc.rust-lang.org/cargo
[cargo-audit]: https://crates.io/crates/cargo-audit
[cargo-deny]: https://crates.io/crates/cargo-deny
[clippy]: https://github.com/rust-lang/rust-clippy
[clojure]: https://clojure.org
[composer]: https://getcomposer.org/
[conftest]: https://www.conftest.dev
[cross]: https://github.com/cross-rs/cross
[cue]: https://cuelang.org
[damon]: https://github.com/hashicorp/damon
[dhall]: https://dhall-lang.org
[dhall-bash]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-bash
[dhall-csv]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-csv
[dhall-docs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-docs
[dhall-json]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-json
[dhall-lsp-server]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-lsp-server
[dhall-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-nixpkgs]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nixpkgs
[dhall-openapi]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-openapi
[dhall-text]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-text
[dhall-to-nix]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-nix
[dhall-toml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-toml
[dhall-yaml]: https://github.com/dhall-lang/dhall-haskell/tree/master/dhall-yaml
[dune]: https://dune.build
[elixir]: https://elixir-lang.org
[elm]: https://elm-lang.org
[elm2nix]: https://github.com/cachix/elm2nix
[flake-utils]: https://github.com/numtide/flake-utils
[gigalixir]: https://www.gigalixir.com
[gleam]: https://gleam.run
[go]: https://go.dev
[godoc]: https://pkg.go.dev/golang.org/x/tools/cmd/godoc
[goimports]: https://pkg.go.dev/golang.org/x/tools/cmd/goimports
[golangci-lint]: https://github.com/golangci/golangci-lint
[gradle]: https://gradle.org
[hashicorp]: https://hashicorp.com
[haskell]: https://haskell.org
[iex]: https://hexdocs.pm/iex/IEx.html
[java]: https://java.com
[kotlin]: https://kotlinlang.org
[leiningen]: https://leiningen.org
[levant]: https://github.com/hashicorp/levant
[lorri]: https://github.com/target/lorri
[mach-nix]: https://github.com/DavHau/mach-nix
[maven]: https://maven.apache.org
[mix]: https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
[nickel]: https://nickel-lang.org
[nim]: https://nim-lang.org
[nimble]: https://github.com/nim-lang/nimble
[niv]: https://github.com/nmattia/niv
[nix]: https://nixos.org
[nix-cue]: https://github.com/jmgilman/nix-cue
[nixfmt]: https://github.com/serokell/nixfmt
[nixpkgs]: https://github.com/NixOS/nixpkgs
[nix-direnv]: https://github.com/nix-community/nix-direnv
[node]: https://nodejs.org
[node2nix]: https://github.com/svanderburg/node2nix
[nomad]: https://nomadproject.io
[nomad-autoscaler]: https://github.com/hashicorp/nomad-autoscaler
[nomad-pack]: https://github.com/hashicorp/nomad-pack
[npm]: https://npmjs.org
[ocaml]: https://ocaml.org
[ocamlformat]: https://github.com/ocaml-ppx/ocamlformat
[odoc]: https://github.com/ocaml/odoc
[opa]: https://openpolicyagent.org
[packer]: https://packer.io
[pip]: https://pypi.org/project/pip
[phoenix]: https://phoenixframework.org
[php]: https://php.net/
[pnpm]: https://pnpm.io
[protobuf]: https://developers.google.com/protocol-buffers
[Purescript]: https://github.com/purescript/purescript
[purescript-language-server]: https://github.com/nwolverson/purescript-language-server
[purs-tidy]: https://github.com/natefaubion/purescript-tidy
[python]: https://python.org
[release]: https://github.com/NixOS/nixpkgs/releases/tag/22.11
[ruby]: https://ruby-lang.org
[rust]: https://rust-lang.org
[rust-analyzer]: https://rust-analyzer.github.io
[scala]: https://scala-lang.org
[statix]: https://github.com/nerdypepper/statix
[sbt]: https://www.scala-sbt.org
[spago]: https://github.com/purescript/spago
[terraform]: https://terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
[tflint]: https://github.com/terraform-linters/tflint
[vault]: https://www.vaultproject.io
[virtualenv]: https://pypi.org/project/virtualenv
[vulnix]: https://github.com/flyingcircusio/vulnix
[yarn]: https://yarnpkg.com
[zig]: https://ziglang.org

