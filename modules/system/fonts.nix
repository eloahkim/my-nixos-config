{ ... }:
{
  flake.modules.nixos."system/fonts" = { pkgs, ... }: {
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
