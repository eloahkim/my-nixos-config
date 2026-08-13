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
        # áudio via PipeWire (libpipewire-0.3.so.0) — exigida por builders Electron
        pipewire
        # acesso gráfico/ATK (libatk, libatk-bridge, libatspi) — no 26.05 o
        # at-spi2-core já engloba os aliases `atk`/`at-spi2-atk`
        at-spi2-core
        # impressão (libcups) e XML (libexpat) — exigidas por builders Electron
        cups
        expat
        # mozilla NSS/nspr (libnspr4.so, libnss3.so, ...) — exigidas por builders Electron
        nss
        nspr
        # device/udev (libudev.so.1) — fica no out do systemd
        systemd
      ];
    };
  };
}
