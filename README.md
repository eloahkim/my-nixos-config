# NixOS dotfiles

Configuração do NixOS usando Nix Flakes. Host atual: **lilith** (Lenovo IdeaPad S145).

## Estrutura

```
flake.nix                     # Inputs (nixpkgs 26.05, unstable, mango, noctalia, sops-nix) e outputs
host/
  configuration.nix           # Config base do sistema + bloco my-nixos.* (o que está ligado)
  hardware-configuration.nix  # Gerado pelo nixos-generate-config (não editar à mão)
  disko-config.nix            # Layout de disco
nixosModules/
  default.nix                 # Índice: importa todos os módulos abaixo
  <categoria>/<feature>.nix   # Um feature por arquivo (define options + config)
secrets/                      # Secrets cifrados com sops (não abrir)
```

## Convenção `my-nixos.*`

Cada módulo em `nixosModules/<categoria>/<nome>.nix` define uma opção
`options.my-nixos.<categoria>.<nome>.enable` e só aplica a config quando ligada.

As habilitações ficam centralizadas no bloco `my-nixos` de `host/configuration.nix`.

Para adicionar uma feature:
1. Criar `nixosModules/<categoria>/<feature>.nix` com `options` + `config`;
2. Importá-la no `nixosModules/default.nix`;
3. Ligar em `host/configuration.nix` (`<categoria>.<feature>.enable = true`).

## Comandos

- Rebuild: `sudo nixos-rebuild switch --flake ~/.nixos/my-nixos-config/.#lilith`
- Atualizar inputs: `nix flake update`
- Editar secrets: `cd secrets && sops secrets.yaml`

## Configs imperativas (fora do Nix)

Nem tudo vive no repositório — por decisão, alguns configs são gerenciados fora:

- `~/.config/mango/` — config do compositor Mango (inclui binds/layout);
- `~/.config/emacs/` — Emacs (`init.el` → `config.org` via org-babel);
- Noctalia gera `~/.config/mango/noctalia.conf` e temas (css/cores) automaticamente.

## Pitfalls

- **`git add` antes de rebuild/eval**: o flake usa o índice do git; arquivo novo
  não stageado não é visto.
- **Plugin do Navidrome**: o ID do agente é `apple-music-plugin` (não `apple-music`);
  vem compilado do nixpkgs (`services.navidrome.plugins`).
- **Navidrome roda com `ProtectHome = false`** forçado, pois os dados vivem em
  `/home/kim/Dados_externos/Navidrome`.
- **Noctalia usa o branch `cachix`** do flake upstream (binários vêm do cachix).
