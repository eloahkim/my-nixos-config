{ pkgs, ... }:
{
  languages.go = {
    enable = true;
    lsp.enable = true;
    delve.enable = true;
  };

  packages = with pkgs; [
    gotools
    golangci-lint
  ];
}
