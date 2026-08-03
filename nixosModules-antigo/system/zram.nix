{ config, pkgs, lib, ... }:

{
  options.my-nixos.system.zram.enable = lib.mkEnableOption "Habilitar zram";
  config = lib.mkIf config.my-nixos.system.zram.enable {
    zramSwap = {
        enable = true;
        algorithm = "zstd";
        priority = 100;
        memoryPercent = 50;
    };

    swapDevices = [ {
       device = "/swap/swapfile";
       size = 6*1024;
       priority = 10;
    } ];
  };
}
