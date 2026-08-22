{ pkgs, ... }:
{
  languages.java = {
    enable = true;
    jdk.package = pkgs.javaPackages.compiler.temurin-bin.jdk-21;
    maven.enable = true;
  };

  packages = with pkgs; [
    jdt-language-server
  ];
}