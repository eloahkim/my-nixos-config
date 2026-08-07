{ ... }:
{
  flake.modules.nixos."system/devenv" = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.devenv ];
  };
}