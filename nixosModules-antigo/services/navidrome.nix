{ config, pkgs, lib, ... }:
# Navidrome - "streaming" de música self-hosted
{
  options.my-nixos.services.navidrome.enable = lib.mkEnableOption "Habilitar Navidrome";
  config = lib.mkIf config.my-nixos.services.navidrome.enable {
    assertions = [{
      assertion = config.sops.templates ? "navidrome.env";
      message = "o aspecto services/navidrome precisa que o aspecto system/secrets também esteja importado no host";
    }];

    services.navidrome = {
      enable = true;
      openFirewall = true;

      # Roda como kim: os dados/backup são do usuário (igual ao podman com userns keep-id).
      user = "kim";
      group = "users";

      # Chaves do LastFM vêm do sops (ND_LASTFM_APIKEY / ND_LASTFM_SECRET).
      environmentFile = config.sops.templates."navidrome.env".path;

      # Plugin apple-music (metadados do iTunes/Apple Music): compilado pelo
      # nixpkgs e embutido no store; nada de baixar/copiar arquivo manual.
      plugins = [ pkgs.navidromePlugins.apple-music ];

      settings = {
        Address = "0.0.0.0"; # LAN, como o compose publicando 4533.
        Port = 4533;
        EnableInsightsCollector = true;

        Plugins.Enabled = true; # default já é true; explícito por clareza.

        LogLevel = "info";
        SessionTimeout = "24h";
        DefaultLanguage = "pt-br";

        MusicFolder = "/home/kim/Dados_externos/jellyfin/media/Músicas/Álbuns";
        DataFolder = "/home/kim/Dados_externos/Navidrome/data";
        CacheFolder = "/home/kim/Dados_externos/Navidrome/data/cache";

        Backup = {
          Path = "/home/kim/Dados_externos/Navidrome/backup";
          Schedule = "30 11 * * 5";
          Count = 3;
        };

        # ID do plugin vem do nome do .ndp: apple-music-plugin.
        Agents = "apple-music-plugin,lastfm,deezer,listenbrainz";

        LastFM = {
          Language = "pt,en";
          ScrobbleFirstArtistOnly = true;
          # ApiKey/Secret agora via environmentFile (sops).
        };

        Deezer.Language = "pt-br,en";

        Scanner = {
          ArtistArtPriority = "artist.*, album/artist.*, external";
          SubsonicArtistParticipations = true;
        };

        PID = {
          Track = "musicbrainz_trackid|albumid,discnumber,tracknumber,title";
          Album = "musicbrainz_albumid|albumartistid,album,albumversion,releasedate";
        };
      };
    };

    # O default do módulo usa ProtectHome=true (esconde /home). Como os dados
    # moram em /home/kim e rodamos como kim, desligamos:
    systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce false;
  };
}
