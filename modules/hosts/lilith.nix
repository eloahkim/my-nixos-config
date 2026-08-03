{ inputs, ... }:
{
  flake.nixosConfigurations.lilith = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      ../../hardware/lilith-hardware-configuration.nix
      ../../hardware/lilith-disko-config.nix
      inputs.disko.nixosModules.disko
      inputs.nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
      inputs.home-manager.nixosModules.home-manager

      # transição: ainda aponta pra pasta antiga
      ../../nixosModules-antigo/default.nix

      # Fase 2 — aspectos de system/
      inputs.self.modules.nixos.base
      inputs.self.modules.nixos."system/secrets"
      inputs.self.modules.nixos."system/shell"
      inputs.self.modules.nixos."system/bluetooth"
      inputs.self.modules.nixos."system/keyboard"
      inputs.self.modules.nixos."system/pipewire"
      inputs.self.modules.nixos."system/zram"
      inputs.self.modules.nixos."system/fonts"
      inputs.self.modules.nixos."system/nix-ld"

      ({ config, pkgs, inputs, ... }:
        {
          nixpkgs.hostPlatform = "x86_64-linux";

          # Bootloader.
          boot.loader.systemd-boot.enable = true;
          boot.loader.efi.canTouchEfiVariables = true;

          # Sysrq
          boot.kernel.sysctl."kernel.sysrq" = 1;

          networking.hostName = "lilith";

          # Enable networking
          networking.networkmanager.enable = true;

          # Set your time zone.
          time.timeZone = "America/Maceio";

          # Select internationalisation properties.
          i18n.defaultLocale = "pt_BR.UTF-8";

          i18n.extraLocaleSettings = {
            LC_ADDRESS = "pt_BR.UTF-8";
            LC_IDENTIFICATION = "pt_BR.UTF-8";
            LC_MEASUREMENT = "pt_BR.UTF-8";
            LC_MONETARY = "pt_BR.UTF-8";
            LC_NAME = "pt_BR.UTF-8";
            LC_NUMERIC = "pt_BR.UTF-8";
            LC_PAPER = "pt_BR.UTF-8";
            LC_TELEPHONE = "pt_BR.UTF-8";
            LC_TIME = "pt_BR.UTF-8";
          };

          # Configure keymap in X11
          services.xserver = {
            xkb.layout = "br";
            xkb.variant = "abnt2";
          };

          # Configure console keymap
          console.keyMap = "br-abnt2";

          # Enable CUPS to print documents.
          services.printing.enable = true;

          # Define a user account.
          users.users.kim = {
            isNormalUser = true;
            description = "Kim";
            extraGroups = [ "networkmanager" "wheel" ];
            packages = with pkgs; [
              #  thunderbird
            ];
          };

          # xdg-portals
          xdg.portal = {
            enable = true;
            xdgOpenUsePortal = true;
          };

          # Tuned
          services.tuned = {
            enable = true;
            ppdSupport = true;
          };

          # Allow unfree packages
          nixpkgs.config.allowUnfree = true;

          # Desktop Modular
          my-nixos = {
            desktop = {
              niri.enable = false;
              mango.enable = true;
              noctalia.enable = true;
              plasma.enable = false;
              gnome.enable = false;
            };
            services = {
              flatpak.enable = true;
              gaming.enable = true;
              jellyfin.enable = false;
              navidrome.enable = true;
              podman.enable = true;
              fhs.enable = true;
            };
            # Virtualização
            virt.virtmanager.enable = false;
            # Coisas do sistema migradas para aspects na Fase 2
            apps = {
              firefox.enable = true;
              mpv.enable = true;
              ungoogled.enable = false;
              vivaldi.enable = false;
              general.enable = true;
              git.enable = true;
              vim.enable = true;
              emacs.enable = true;
            };
            firewall.enable = true;
            network.avahi.enable = true;
          };

          # Enable the default ports on firewall.
          services.syncthing.openDefaultPorts = true;

          # Coleta de lixo automática
          nix = {
            settings.auto-optimise-store = true;
            gc = {
              automatic = true;
              dates = "weekly";
              options = "--delete-older-than 7d";
            };
          };

          # Habilita opções que ainda são experimentais (mais muito utilizadas) no NixOS
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          # Enable the OpenSSH daemon.
          services.openssh = {
            enable = true;
            allowSFTP = true;
          };

          system.stateVersion = "24.05";
        })

      # home-manager config (mantém o mesmo bloco do flake.nix antigo)
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.kim = {
          imports = [
            ../../home
            inputs.self.modules.homeManager.base
          ];
        };
      }
    ];
  };
}
