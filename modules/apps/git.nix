{ ... }:
{
  flake.modules.nixos."apps/git" = { ... }: {
    programs.git.enable = true;
  };

  flake.modules.homeManager."apps/git" = { ... }: {
    programs.git = {
      enable = true;
      settings.user = {
        name = "eloahkim";
        email = "kimeloah18@gmail.com";
      };
    };
  };
}
