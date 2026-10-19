{ ... }:
# Minhas configurações Jellyfin
{
  flake.modules.nixos."services/jellyfin" = { lib, ... }: {
    services.jellyfin = {
      enable = true;
      user = "kim";
      group = "users";
      openFirewall = true;
      cacheDir = "/home/kim/Dados_externos/jellyfin/cache";
      configDir = "/home/kim/Dados_externos/jellyfin/config";
      dataDir = "/home/kim/Dados_externos/jellyfin/data";
      logDir = "/home/kim/Dados_externos/jellyfin/log";

      # Aceleração por hardware (AMD Vega / VAAPI)
      hardwareAcceleration = {
        enable = true;
        type = "vaapi";
        device = "/dev/dri/renderD128";
      };

      # Fonte da verdade do encoding.xml (mudanças na UI são sobrescritas).
      forceEncodingConfig = true;

      transcoding = {
        hardwareDecodingCodecs = {
          h264 = true;
          hevc = true;
          vp9 = true;
        };
        enableHardwareEncoding = true;
        enableToneMapping = false;
        throttleTranscoding = true;
        maxConcurrentStreams = 2;
      };
    };

    # Não inicia no boot; ligar sob demanda com `sudo systemctl start jellyfin`.
    systemd.services.jellyfin.wantedBy = lib.mkForce [ ];
  };
}
