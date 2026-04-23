{ config, pkgs, lib, ... }:

{
  options.my-nixos.services.flatpak.enable = lib.mkEnableOption "Habilitar flatpak e algumas fontes";
  config = lib.mkIf config.my-nixos.services.flatpak.enable {
    # Habilita o flatpak.
    services.flatpak.enable = true;
    fonts = {
      fontDir.enable = true;
      packages = with pkgs; [
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        liberation_ttf
        jetbrains-mono
        font-awesome
        inter
      ];
    };
  };
}
