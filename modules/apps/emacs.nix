{ ... }:
{
  flake.modules.nixos."apps/emacs" = { pkgs, ... }: {
    # Emacs GUI standalone; sem daemon/emacsclient.
    environment.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    my-nixos.packages = {
      nixd = pkgs.nixd;
      emacs = pkgs.emacs-pgtk;
    };
  };
}
