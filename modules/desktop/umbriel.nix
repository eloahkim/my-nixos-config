{ inputs, ... }:
{
  flake.modules.nixos."desktop/umbriel" = { pkgs, inputs, lib, ... }: {
    imports = [
      inputs.umbriel.nixosModules.default
    ];

    programs.umbriel.enable = true;
    programs.dconf.enable = true;

    services.displayManager.ly = {
      enable = true;
      settings = {
	numlock = true;
	animation = "matrix";
      };
    };
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.swaylock = { };

    services.udisks2.enable = true;
    hardware.i2c.enable = true;
    users.users.kim.extraGroups = [ "i2c" ];

    programs.kdeconnect.enable = true;

    my-nixos.packages = {
      inherit (pkgs) qalculate-gtk ncdu ddcutil imv mediainfo foot zathura
      cliphist wl-clipboard libnotify udiskie nwg-look glib
      gsettings-desktop-schemas adw-gtk3 gnome-themes-extra bibata-cursors
      papirus-icon-theme jq grim slurp;
      inherit (pkgs.kdePackages) qt6ct;
    };

    nix.settings = {
      extra-substituters = [ "https://umbriel.cachix.org" ];
      extra-trusted-public-keys = [
	"umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };
  };
}
