{
  description = "Get started with flakes fast with these utils";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.legacyPackages.${system}.lib.getName pkg) [
              "vscode-with-extensions"
              "vscode"
            ];
        };
      in {
        formatter = pkgs.alejandra;

        lib = {
          rust = import ./lib/rust.nix {inherit pkgs;};
          nix = import ./lib/nix.nix {inherit pkgs;};
          editor = import ./lib/editor.nix {inherit pkgs;};
        };

        devShells.rust = with self.lib;
          editor.vscode {
            extensions = editor.vscode-extensions.vim ++ rust.vscode-extensions;
          };
      }
    );
}
