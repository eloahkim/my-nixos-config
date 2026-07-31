{ config, pkgs, lib, ... }:
{
  # Configurações do emacs
  options.my-nixos.apps.emacs.enable = lib.mkEnableOption "Habilitar emacs";
  config = lib.mkIf config.my-nixos.apps.emacs.enable {
    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      startWithGraphical = true;
      defaultEditor = true;
    };
  };
}
