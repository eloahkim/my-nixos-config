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
    # Noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };
    # Mango
    mangowm = {
      url = "github:mangowm/mango/wl-only";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, disko, mangowm, ... }@inputs: {
    # Aqui é necessário colocar o hostname da máquina.
    nixosConfigurations = {
      "lilith" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Isso faz com que o configuration.nix continue funcionando.
          ./host/configuration.nix
          ./host/disko-config.nix
          ./nixosModules/default.nix
          # Módulo que corrige peculiaridades da minha máquina atual.
          nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
          disko.nixosModules.disko
        ];
      };
    };
  };
}
