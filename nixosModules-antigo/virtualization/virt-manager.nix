{ config, pkgs, lib, ... }:

{
  options.my-nixos.virt.virtmanager.enable = lib.mkEnableOption "Habilitar virt-manager qemu-kvm";
  config = lib.mkIf config.my-nixos.virt.virtmanager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    networking.firewall.trustedInterfaces = [ "virbr0" ];
  };
}
