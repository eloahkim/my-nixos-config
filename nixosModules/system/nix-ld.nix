{ config, pkgs, lib, ... }:

{
  options.my-nixos.system.nix-ld.enable = lib.mkEnableOption "Habilitar nix-ld";
  config = lib.mkIf config.my-nixos.system.nix-ld.enable {
    # nix-ld: roda binários fechados/AppImages transparentemente, sem entrar
    # num shell FHS (o `fhs` fica só para dev/build).
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # runtimes base
        stdenv.cc.cc.lib
        zlib
        # fontes
        fontconfig
        freetype
        # gráficos (GUI/AppImage)
        libGL
        libglvnd
        wayland
        libxkbcommon
        libx11
        libxcb
        libxext
        libxcursor
        libxrandr
        libxi
        gtk3
        gdk-pixbuf
        cairo
        pango
        glib
        # rede
        openssl
        curl
        # AppImage (FUSE2: fornece libfuse.so.2)
        fuse
        # áudio
        alsa-lib
        libpulseaudio
      ];
    };
  };
}
