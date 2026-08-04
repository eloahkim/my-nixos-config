{ ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.python = pkgs.mkShell {
      packages = with pkgs; [
        uv
        python3
        basedpyright
        ruff
        black
        isort
      ];
    };
  };
}
