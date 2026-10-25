{ pkgs, ... }:
{
  packages = with pkgs; [
    uv
    python3
    basedpyright
    ruff
    black
    isort
    python3Packages.debugpy
    python3Packages.pytest
  ];
}
