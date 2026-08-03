{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];

  # este import é o que de fato cria a opção `flake.modules.<classe>.<nome>` —
  # sem ele, nenhum aspecto (mango.nix, firefox.nix etc.) teria onde se registrar,
  # mesmo com o import-tree escaneando `modules/` corretamente.
  imports = [ inputs.flake-parts.flakeModules.modules ];
}
