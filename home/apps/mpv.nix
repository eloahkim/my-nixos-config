{ osConfig, pkgs, lib, ... }:

{
  config = lib.mkIf osConfig.my-nixos.apps.mpv.enable {
    programs.mpv = {
      enable = true;
      config = {
        vo = "gpu-next";
        ao = "pulse";
        hwdec = "vaapi";
        save-position-on-quit = true;
        keep-open = true;
      };
    };
  };
}
