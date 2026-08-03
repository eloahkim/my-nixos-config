{ pkgs, ... }:
{
  flake.modules.nixos."apps/emacs" = { pkgs, ... }: {
    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      startWithGraphical = true;
      defaultEditor = true;
    };

    my-nixos.packages = {
      nixd = pkgs.nixd;
      inherit (pkgs) gcc gnumake;
    };
  };
}
