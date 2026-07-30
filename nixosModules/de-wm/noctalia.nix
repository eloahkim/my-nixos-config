{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  options.my-nixos.desktop.noctalia.enable = lib.mkEnableOption "Habilitar Noctalia";
  config = lib.mkIf config.my-nixos.desktop.noctalia.enable {
    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };
  };
}