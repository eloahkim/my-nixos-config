{ pkgs, ... }:
{
  packages = with pkgs; [
    uv
    python3
    basedpyright
    ruff
    black
    isort
  ];
}