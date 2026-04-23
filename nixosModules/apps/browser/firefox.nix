{ config, pkgs, lib, ... }:

{
  options.my-nixos.apps.firefox.enable = lib.mkEnableOption "Habilitar Firefox e seu pacote de línguas";
  config = lib.mkIf config.my-nixos.apps.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "pt-BR" ];
    };
  };
}
