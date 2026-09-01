rec {
  elixir = {
    path = ./elixir;
    description = "Elixir development environment";
  };

  go = {
    path = ./go;
    description = "Go (Golang) development environment";
  };

  # need to verify if unfree
  # hashi = {
  #   path = ./hashi;
  #   description = "HashiCorp DevOps tools development environment";
  # };

  nix = {
    path = ./nix;
    description = "Nix development environment";
  };

  python = {
    path = ./python;
    description = "Python app development environment";
  };

  pyscript = {
    path = ./pyscript;
    description = "A simple python script environment";
  };

  latex = {
    path = ./latex;
    description = "A minimal customized latex template for documentation work";
  };

  typst = {
    path = ./typst;
    description = "Typst markup environment";
  };

  typeset = {
    path = ./typeset;
    description = "Typesetting with typst's min-book";
  };

  simple-container = {
    path = ./simple-container;
    description = "A simple web server running in a nix container";
  };


  lua = {
    path = ./lua;
    description = "A simple lua dev environment";
  };

  bash = {
    path = ./bash;
    description = "A simple bash shell dev environment";
  };

}
