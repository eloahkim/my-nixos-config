{ config, pkgs, lib, ... }:
{
  # Configurações do vim
  options.my-nixos.apps.vim.enable = lib.mkEnableOption "Habilitar vim";
  config = lib.mkIf config.my-nixos.apps.vim.enable {
    programs.vim = {
      enable = true;
    };
  };
}
