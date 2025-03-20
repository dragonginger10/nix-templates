{
  description = "A Nix-flake-based Elixir development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin"];
    forEachSystem = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    devShells = forEachSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages =
          (with pkgs; [elixir])
          ++ pkgs.lib.optional (pkgs.stdenv.isLinux) (with pkgs; [gigalixir inotify-tools libnotify])
          ++ pkgs.lib.optional (pkgs.stdenv.isDarwin) ((with pkgs; [terminal-notifier])
            ++ (with pkgs.darwin.apple_sdk.frameworks; [CoreFoundation CoreServices]));
      };
    });
  };
}
