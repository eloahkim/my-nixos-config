{ config, pkgs, lib, ... }:
{
  # Fontes do sistema
  options.my-nixos.system.fonts.enable = lib.mkEnableOption "Instala as fontes do sistema";
  config = lib.mkIf config.my-nixos.system.fonts.enable {
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
        nerd-fonts.symbols-only
      ];
    };
  };
}
