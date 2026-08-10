{ ... }:
{
  flake.modules.nixos."system/nh" = { ... }: {
    programs.nh = {
      enable = true;
      flake = "/home/kim/.my-nixos-config";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };
}