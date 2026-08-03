{ ... }:
{
  flake.modules.nixos."system/nix-ld" = { pkgs, ... }: {
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
        libdrm
        wayland
        libxkbcommon
        libx11
        libxcb
        libxext
        libxcursor
        libxrandr
        libxi
        libxshmfence
        libxcomposite
        libxdamage
        libxfixes
        libxrender
        libxinerama
        libXScrnSaver
        libgbm
        gtk3
        gdk-pixbuf
        cairo
        pango
        glib
        harfbuzz
        fribidi
        # Qt/AppImage auxiliares
        dbus
        pcre2
        libpng
        libjpeg
        libwebp
        libtiff
        # criptografia
        libgpg-error
        libgcrypt
        gmp
        pkgs.e2fsprogs.out
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
