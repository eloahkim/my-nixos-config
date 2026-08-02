{
  description = "Meu primeiro Nix Flake";

  inputs = {
    # Fonte dos pacotes oficiais do NixOS, usando o branch nixos-26.05 aqui.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
    mangowm = {
      url = "github:mangowm/mango/wl-only";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Flatpaks declarativos
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, disko, mangowm, home-manager, firefox-addons, ... }@inputs: {
    # Aqui é necessário colocar o hostname da máquina.
    nixosConfigurations = {
      "lilith" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          # Isso faz com que o configuration.nix continue funcionando.
          ./host/configuration.nix
          ./host/disko-config.nix
          ./nixosModules/default.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs; };
	    home-manager.users.kim = import ./home;
	  }
          # Módulo que corrige peculiaridades da minha máquina atual.
          nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
          disko.nixosModules.disko
        ];
      };
    };
  };
}
