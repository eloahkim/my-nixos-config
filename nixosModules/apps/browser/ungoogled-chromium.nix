{ config, pkgs, lib, ... }:

{
  options.my-nixos.apps.ungoogled.enable = lib.mkEnableOption "Habilitar Ungoogled Chromium";
  config = lib.mkIf config.my-nixos.apps.ungoogled.enable {
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
    ];

    # Habilita o Widevine no Ungoogled Chromium
    nixpkgs.config = {
      chromium = {
        enableWideVine = true;
      };
    };
  };
}
