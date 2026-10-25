{ pkgs, lib, ... }:
{
  packages = with pkgs; [
    clang
    clang-tools
    gcc
    gnumake
    cmake
    ninja
    pkg-config
    bear
    lldb
  ] ++ lib.optionals (!pkgs.stdenv.isDarwin) [
    gdb
    valgrind
  ];
}
