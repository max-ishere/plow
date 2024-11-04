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
        pkgs_local = import nixpkgs { inherit system; };
      in {
        formatter = pkgs_local.alejandra;

        lib = {pkgs}: {
          rust = import ./lib/rust.nix {inherit pkgs;};
          editor = import ./lib/editor.nix {inherit pkgs;};
        };
      }
    );
}
