{ ... }:
{
  flake.modules.nixos."apps/vim" = { ... }: {
    programs.vim.enable = true;
  };
}
