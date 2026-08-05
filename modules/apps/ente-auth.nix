{ ... } : {
  flake.modules.nixos."apps/ente-auth" = { ... }: {
    programs.ente-auth.enable = true;
  };
}
