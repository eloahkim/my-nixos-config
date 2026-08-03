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

    # command-not-found → nix-locate com banco semanal da comunidade
    programs.nix-index-database.enable = true;
  };
}
