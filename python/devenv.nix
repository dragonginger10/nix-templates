{ pkgs, lib, config, inputs, ... }:

{
  packages = [ pkgs.just ];

  languages.python = {
    enable = true;
    uv.enable = true;
  };
}
