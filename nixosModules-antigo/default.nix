# Esse módulo é designado para apenas importar todos os outros módulos que existem. Essa é uma maneira mais fácil de habilitar todos os módulos de uma vez, e também faz com que eles sejam alternáveis em algum nível.
{ config, pkgs, inputs, ... }:

{
  imports = [
      ./de-wm/gnome.nix # GNOME Desktop Environment.
      ./de-wm/plasma.nix # KDE Plasma Desktop Environment.
      ./de-wm/niri.nix # Niri
      ./de-wm/mango.nix # Mango
      ./de-wm/noctalia.nix # Noctalia
      ./network/firewall.nix # Configurações do firewall.
      ./network/avahi.nix # Avahi (mDNS/Zeroconf)
      ./services/fhs.nix # Ambiente FHS para executar binários que esperam /usr/lib, /usr/bin, etc.
      ./services/flatpak.nix # Habilita e resolve flatpak.
      ./services/gaming.nix # Tudo relacionado à jogos.
      ./services/jellyfin.nix # Jellyfin, meu "streaming caseiro"
      ./services/navidrome.nix # Navidrome, meu "streaming" de música.
      ./services/podman.nix # Habilita o podman.
      ./virtualization/virt-manager.nix
    ];
}
