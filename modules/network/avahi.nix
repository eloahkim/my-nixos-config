{ ... }:
{
  flake.modules.nixos."network/avahi" = { ... }: {
    services.avahi.enable = true;
  };
}
