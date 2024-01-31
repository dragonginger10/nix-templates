rec {
  elixir = {
    path = ./elixir;
    description = "Elixir development environment";
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

  nix = {
    path = ./nix;
    description = "Nix development environment";
  };

  node = {
    path = ./node;
    description = "Node.js development environment";
  };
  php = {
    path = ./php;
    description = "PHP development environment";
  };

  python = {
    path = ./python;
    description = "Python development environment";
  };
  rust = {
    path = ./rust;
    description = "Rust development environment";
  };

  rust-toolchain = {
    path = ./rust-toolchain;
    description = "Rust development environment with Rust version defined by a rust-toolchain.toml file";
  };

  latex = {
    path = ./latex;
    description = "A minimal customized latex template for documentation work";
  };

  typst = {
    path = ./typst;
    description = "Typst markup environment";
  };

  simple-container = {
    path = ./simple-container;
    description = "A simple web server running in a nix container";
  };

  shell = {
    path = ./shell;
    description = "A simple shell dev environment";
  };

  # Aliases
  rt = rust-toolchain;
}
