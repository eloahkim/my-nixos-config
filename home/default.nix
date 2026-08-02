{ ... }: {
  home.username = "kim";
  home.homeDirectory = "/home/kim";
  home.stateVersion = "24.05";

  imports = [
    ./apps/git.nix
    ./apps/firefox.nix
    ./apps/general.nix
  ];
}