{ config, pkgs, lib, ... }:
# Esse módulo corrige um problema que tenho no teclado da minha máquina atual
# deixando ele desabilitado para usar somente teclados externos.
#É uma gambiarra até conseguir consertar de fato.

{
  options.my-nixos.system.keyboard.enable = lib.mkEnableOption "Desativa teclado defeituoso do Lenovo Ideapad S145";
  config = lib.mkIf config.my-nixos.system.keyboard.enable {
    boot.kernelParams = [ "modprobe.blacklist=atkbd" "i8042.nokbd" ];
  };
}

