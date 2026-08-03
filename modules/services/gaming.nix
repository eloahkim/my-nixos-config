{ ... }:
{
  flake.modules.nixos."services/gaming" = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

    programs.steam.extraPackages = with pkgs; [
      mangohud
    ];

    programs.gamemode.enable = true;
    hardware.steam-hardware.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];

    my-nixos.packages = {
      #dolphin-emu # Emulador de GameCube e Wii.
      inherit (pkgs) heroic winetricks;
      #prismlauncher # Launcher de Minecraft.
      inherit (pkgs.wineWow64Packages) stable;
    };
  };
}
