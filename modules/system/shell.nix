{ inputs, ... }:
{
  flake.modules.nixos."system/shell" = { ... }: {
    imports = [
      inputs.nix-index-database.nixosModules.default
    ];

    programs.bash.shellAliases = {
      neofetch-like = "fastfetch -c neofetch";
      open = "xdg-open";
      #nixos-upgrade = "./~/.nixos/nixos-upgrade.sh";
    };
    programs.ssh.startAgent = true;
    services.gnome.gcr-ssh-agent.enable = false; # Mango required

    # command-not-found → nix-locate com banco semanal da comunidade
    programs.nix-index-database.enable = true;
  };
}
