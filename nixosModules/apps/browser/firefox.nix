{ lib, ... }:

{
  options.my-nixos.apps.firefox.enable = lib.mkEnableOption "Habilitar Firefox e seu pacote de línguas";
}
