{ ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.c-cpp = pkgs.mkShell {
      packages = with pkgs; [
        clang
        clang-tools
        gcc
        gnumake
        cmake
        ninja
        pkg-config
        gdb
        valgrind
        bear
      ];
    };
  };
}
