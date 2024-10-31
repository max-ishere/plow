{pkgs, ...}: {
  cratePackage = {
    crate, # lib.cleanSource ./.
    workspace ? crate,
    amend ? {},
  }: let
    src = crate;
    manifest = (pkgs.lib.importTOML (src + /Cargo.toml)).package;
  in
    pkgs.rustPlatform.buildRustPackage ({
        pname = manifest.name;
        inherit (manifest) version;
        cargoLock.lockFile = workspace + /Cargo.lock;
        inherit src;
      }
      // amend);

  vscode-extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
  ];

  shellBuildInputs = with pkgs; [
    rust-analyzer
    rustfmt
    clippy
  ];
}
