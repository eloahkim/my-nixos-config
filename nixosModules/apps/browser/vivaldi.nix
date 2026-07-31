{ config, pkgs, lib, ... }:

# O nixpkgs 26.05 pina o componente ffmpeg proprietário no snap rev 118
# (build antigo "123075"), incompatível com o Vivaldi 8.1.4087.48. Usamos a
# rev 117 / build "git-2026-05-18", que é o que o próprio deb do Vivaldi
# 8.1.4087.48 espera (checksum b2318b0b...398). Revisar quando atualizar.
let
  ffmpegCodecs = pkgs.vivaldi-ffmpeg-codecs.overrideAttrs (old: {
    version = "git-2026-05-18";
    src = pkgs.fetchurl {
      url = "https://api.snapcraft.io/api/v1/snaps/download/XXzVIXswXKHqlUATPqGCj2w2l7BxosS8_117.snap";
      hash = "sha256-YEE7oF8NLGDCQ3gpY5z6B+7xDxcOumjOzwUztJUM+/s=";
    };
  });
in
{
  options.my-nixos.apps.vivaldi.enable = lib.mkEnableOption "Habilitar Vivaldi Browser";
  config = lib.mkIf config.my-nixos.apps.vivaldi.enable {
    environment.systemPackages = [
      (pkgs.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        vivaldi-ffmpeg-codecs = ffmpegCodecs;
        widevine-cdm = pkgs.widevine-cdm;
      })
    ];
  };
}
