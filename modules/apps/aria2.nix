{ ... }:
{
  flake.modules.homeManager."apps/aria2" = { config, ... }: {
    programs.aria2 = {
      enable = true;
      settings = {
        # Alocação de arquivo: falloc é instantâneo no Linux e evita fragmentação
        "file-allocation" = "falloc";

        # Cache de disco para agrupar escritas
        "disk-cache" = "128M";
        "event-poll" = "epoll";

        # Conexões - equilibrado entre velocidade e bom comportamento
        "max-connection-per-server" = 4;
        split = 16;
        "min-split-size" = "1M";

        # Máximo de downloads simultâneos
        "max-concurrent-downloads" = 5;

        # Resume downloads interrompidos
        continue = true;

        # Diretório de download
        dir = "${config.home.homeDirectory}/Downloads/aria2";

        # Segurança e protocolo
        "bt-require-crypto" = true;
        "check-certificate" = true;
        "allow-overwrite" = false;
        "auto-file-renaming" = true;

        # Limite de upload para não engasgar o download
        "max-overall-upload-limit" = "2M";

        # Desativa RPC se não for usado (segurança)
        "enable-rpc" = false;

        # Sessão - salva progresso para retomar depois (opcional)
        "save-session" = "${config.home.homeDirectory}/.config/aria2/session.txt";
        "save-session-interval" = 60;
      };
    };
  };
}
