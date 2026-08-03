{ lib, ... }:

{
  options.my-nixos.apps.mpv.enable = lib.mkEnableOption "Habilitar MPV via Home Manager";
}
