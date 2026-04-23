{ config, pkgs, lib, inputs, ... }:

{
    options.my-nixos.desktop.noctalia.enable = lib.mkEnableOption "Habilitar noctalia (geralmente no Niri)";
    config = lib.mkIf config.my-nixos.desktop.noctalia.enable{
      environment.systemPackages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
}
