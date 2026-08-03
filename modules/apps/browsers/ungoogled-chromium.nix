{ pkgs, ... }:
{
  flake.modules.nixos."apps/browsers/ungoogled-chromium" = { pkgs, ... }: {
    my-nixos.packages = {
      inherit (pkgs) ungoogled-chromium;
    };

    # Habilita o Widevine no Ungoogled Chromium
    nixpkgs.config = {
      chromium = {
        enableWideVine = true;
      };
    };
  };
}
