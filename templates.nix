{
  clojure = {
    path = ./clojure;
    description = "Clojure development environment";
  };

  cue = {
    path = ./cue;
    description = "Cue development environment";
  };

  dhall = {
    path = ./dhall;
    description = "Dhall development environment";
  };

  elixir = {
    path = ./elixir;
    description = "Elixir development environment";
  };

  elm = {
    path = ./elm;
    description = "Elm development environment";
  };

  gleam = {
    path = ./gleam;
    description = "Gleam development environment";
  };

  go = {
    path = ./go;
    description = "Go (Golang) development environment";
  };

  hashi = {
    path = ./hashi;
    description = "HashiCorp DevOps tools development environment";
  };

  haskell = {
    path = ./haskell;
    description = "Haskell development environment";
  };

  java = {
    path = ./java;
    description = "Java development environment";
  };

  kotlin = {
    path = ./kotlin;
    description = "Kotlin development environment";
  };

  nickel = {
    path = ./nickel;
    description = "Nickel development environment";
  };

  nim = {
    path = ./nim;
    description = "Nim development environment";
  };

  nix = {
    path = ./nix;
    description = "Nix development environment";
  };

  node = {
    path = ./node;
    description = "Node.js development environment";
  };

  opa = {
    path = ./opa;
    description = "Open Policy Agent development environment";
  };

  php = {
    path = ./php;
    description = "PHP development environment";
  };

  protobuf = {
    path = ./protobuf;
    description = "Protobuf development environment";
  };

  purescript = {
    path = ./purescript;
    description = "Purescript development environment";
  };

  python = {
    path = ./python;
    description = "Python development environment";
  };

  ruby = {
    path = ./ruby;
    description = "Ruby development environment";
  };

  rust = {
    path = ./rust;
    description = "Rust development environment";
  };

  rust-toolchain = {
    path = ./rust-toolchain;
    description = "Rust development environment with Rust version defined by a rust-toolchain.toml file";
  };

  scala = {
    path = ./scala;
    description = "Scala development environment";
  };

  zig = {
    path = ./zig;
    description = "Zig development environment";
  };

  latex = {
    path = ./latex;
    description = "A minimal customized latex template for documentation work";
  };

  typst = {
    path = ./typst;
    description = "Typst markup environment";
  };

  # Aliases
  rt = rust-toolchain;
}
