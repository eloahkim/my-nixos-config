{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "pt-BR" ];
  };
}
