{ ... }:
{
  # Esse módulo corrige um problema que tenho no teclado da minha máquina atual
  # deixando ele desabilitado para usar somente teclados externos.
  # É uma gambiarra até conseguir consertar de fato.
  flake.modules.nixos."system/keyboard" = { ... }: {
    boot.kernelParams = [ "modprobe.blacklist=atkbd" "i8042.nokbd" ];
  };
}
