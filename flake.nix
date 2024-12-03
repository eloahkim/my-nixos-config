{
  description = "Meu primeiro Nix Flake";

  inputs = {
    # Fonte dos pacotes oficiais do NixOS, usando o branch nixos-24.11 aqui.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    # Aqui é necessário colocar o hostname da máquina.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Isso faz com que o configuration.nix continue funcionando.
        ./host/configuration.nix
        ./nixosModules/default.nix
        # Módulo que corrige peculiaridades da minha máquina atual.
        nixos-hardware.nixosModules.lenovo-ideapad-s145-15api
      ];
    };
  };
}
