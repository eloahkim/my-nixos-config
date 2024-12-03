{ config, pkgs, ... }:
# Esse módulo corrige um problema que tenho no teclado da minha máquina atual
# deixando ele desabilitado para usar somente teclados externos.
#É uma gambiarra até conseguir consertar de fato.

{
  services.udev.extraRules = ''
  KERNEL=="event1", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
