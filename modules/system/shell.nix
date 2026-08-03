{ ... }:
{
  flake.modules.nixos."system/shell" = { ... }: {
    programs.bash.shellAliases = {
      neofetch-like = "fastfetch -c neofetch";
      open = "xdg-open";
      #nixos-upgrade = "./~/.nixos/nixos-upgrade.sh";
    };

    programs.nix-index.enable = true;
  };
}
