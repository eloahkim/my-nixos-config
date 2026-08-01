{ config, pkgs, lib, inputs, ... }:
# Secrets via sops-nix: decripta em /run/secrets na ativação.
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.my-nixos.system.secrets.enable = lib.mkEnableOption "Habilitar secrets (sops-nix)";
  config = lib.mkIf config.my-nixos.system.secrets.enable {
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
        content = ''
          ND_LASTFM_APIKEY=${config.sops.placeholder."lastfm-apikey"}
          ND_LASTFM_SECRET=${config.sops.placeholder."lastfm-secret"}
        '';
      };
    };
  };
}
