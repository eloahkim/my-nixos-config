{ ... }:
{
  flake.modules.nixos."system/bluetooth" = { ... }: {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
