{ osConfig, lib, ... }: {
  config = lib.mkIf osConfig.my-nixos.apps.git.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "eloahkim";
	email = "kimeloah18@gmail.com";
      };
    };
  };
}