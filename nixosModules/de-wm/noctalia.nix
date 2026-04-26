{ config, pkgs, lib, inputs, ... }:

{
   options.my-nixos.desktop.noctalia.enable = lib.mkEnableOption "Habilitar noctalia (geralmente no Niri)";
   config = lib.mkIf config.my-nixos.desktop.noctalia.enable {
     nix.settings = {
     extra-substituters = [ "https://noctalia.cachix.org" ];
     extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWp0xNFQsEqiKkP4+t7FvxkE=" ];
   };
     environment.systemPackages = with pkgs; [
       inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
     ];
   };
}
