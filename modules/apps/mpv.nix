{ ... }:
{
  flake.modules.homeManager."apps/mpv" = { ... }: {
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
