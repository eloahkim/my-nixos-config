{ ... }:
{
  flake.modules.nixos."system/zram" = { ... }: {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
      memoryPercent = 50;
    };

    swapDevices = [ {
      device = "/swap/swapfile";
      size = 6 * 1024;
      priority = 10;
    } ];
  };
}
