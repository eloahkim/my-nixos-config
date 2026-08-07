{ ... }:
{
  flake.modules.nixos."virtualization/virt-manager" = { pkgs, ... }: {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = true;
    environment.systemPackages = with pkgs; [
      dnsmasq
      virtiofsd
    ];
    networking.firewall.trustedInterfaces = [ "virbr0" ];
  };
}
