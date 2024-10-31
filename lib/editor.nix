{pkgs, ...}: {
  vscode = {
    buildInputs ? [],
    extensions ? [],
    amend ? {},
  }:
    pkgs.mkShell ({
        buildInputs =
          [
            (pkgs.vscode-with-extensions.override {
              vscodeExtensions = extensions;
            })
          ]
          ++ buildInputs;
      }
      // amend);

  vscode-extensions = with pkgs.vscode-extensions; {
    vim = [
      vscodevim.vim
    ];
  };
}
