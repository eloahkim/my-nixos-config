{ config, pkgs, lib, ... }:
# Git config
{
  options.my-nixos.apps.git.enable = lib.mkEnableOption "Habilitar git";
  config = lib.mkIf config.my-nixos.apps.git.enable {
    programs.git.enable = true;
  };
}
