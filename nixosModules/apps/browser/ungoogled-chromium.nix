{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];

  # Habilita o Widevine no Ungoogled Chromium
  nixpkgs.config = {
    chromium = {
      enableWideVine = true;
    };
  };
}
