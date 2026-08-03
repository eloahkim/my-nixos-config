{ inputs, ... }:
{
  flake.modules.nixos."system/secrets" = { config, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      secrets = {
        # root:root / 0400 por padrão; o Navidrome nunca lê estes arquivos direto.
        "lastfm-apikey" = { };
        "lastfm-secret" = { };
      };

      templates."navidrome.env" = {
        owner = "kim";
        group = "users";
        mode = "0400";
        restartUnits = [ "navidrome.service" ];
        content = ''
          ND_LASTFM_APIKEY=${config.sops.placeholder."lastfm-apikey"}
          ND_LASTFM_SECRET=${config.sops.placeholder."lastfm-secret"}
        '';
      };
    };
  };
}
