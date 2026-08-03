# Minhas configurações do bash
{ config, pkgs, lib, ... }:
{
  options.my-nixos.system.shell.enable = lib.mkEnableOption "Habilitar alias do shell (bash)";
  config = lib.mkIf config.my-nixos.system.shell.enable {
    programs.bash.shellAliases = {
      neofetch-like = "fastfetch -c neofetch";
      open = "xdg-open";
      #nixos-upgrade = "./~/.nixos/nixos-upgrade.sh";
    };
  };
}
