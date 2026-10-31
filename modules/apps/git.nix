{ ... }:
{
  flake.modules.nixos."apps/git" = { ... }: {
    programs.git.enable = true;
  };

  flake.modules.homeManager."apps/git" = { ... }: {
    programs.git = {
      enable = true;
      settings.user = {
        name = "nicolasg87";
        email = "nicolas_gabriel87@outlook.com";
      };
    };
  };
}
