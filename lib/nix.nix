{pkgs}: {
  shellBuildInputs = with pkgs; [nixd];
  vscode-extensions = with pkgs.vscode-extensions; [jnoortheen.nix-ide];
}
