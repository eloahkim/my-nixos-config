# NixOS dotfiles

> [!NOTE]
> Esta é uma configuração **pessoal**. Decisões aqui servem à máquina (lilith)
> e às preferências do autor — não é um template. Aproveite ideias, não o repo.

Configuração do NixOS usando Nix Flakes com o **Dendritic Pattern**
(flake-parts + import-tree). Host atual: **lilith** (Lenovo IdeaPad S145).

## Estrutura

```
flake.nix                     # Só inputs; outputs = flake-parts (mkFlake + import-tree)
modules/
  flake/
    core.nix                  # systems + import que cria flake.modules.<classe>.<nome>
    constants.nix             # Constants Aspect (myConstants: usuário, hostname, timezone)
  hosts/
    lilith.nix                # O host: lista de aspects que a lilith importa
  system/                     # Simple Aspects (sem enable): secrets, shell, bluetooth, ...
  apps/                       # Simple Aspects: git, vim, mpv, emacs, general
    browsers/                 # firefox, ungoogled-chromium, vivaldi
  desktop/                    # Multi Context Aspects: mango, plasma, niri, gnome, noctalia
  services/                   # navidrome, jellyfin, podman, flatpak, fhs, gaming
  network/                    # firewall, avahi
  virtualization/             # virt-manager
hardware/                     # lilith-hardware-configuration.nix, lilith-disko-config.nix
secrets/                      # Secrets cifrados com sops (não abrir)
```

## Dendritic: uma feature = um arquivo (aspect)

Cada arquivo em `modules/` é um **aspect**: um registrador
`flake.modules.<classe>.<nome>` (classe `nixos` ou `homeManager`). Habilitar um
aspect = **importá-lo** na lista do host — não existe mais toggle `enable`.

- `inputs.self.modules.nixos."system/shell"` — aspect só de sistema;
- `inputs.self.modules.nixos."apps/git"` — aspect nixos;
- `inputs.self.modules.homeManager."apps/git"` — aspect home-manager;
- `inputs.self.modules.nixos."desktop/mango"` — Multi Context: o aspect nixos já
  "puxa" o home-manager por dentro via `home-manager.sharedModules`.

A lista `modules = [...]` e `home-manager.users.kim.imports = [...]` no host **é**
a documentação do que está ligado.

### Pacotes: Collector Aspect

`modules/system/packages.nix` define dois acumuladores — `my-nixos.packages`
(sistema) e `my-nixos.homePackages` (home) — e cada aspect contribui sua fatia:

```nix
my-nixos.packages = {
  inherit (pkgs) rar unrar jq;
};
```

### Assertions pontuais

Não existe mais `assertions.nix` central. Cada aspect que precisa validação
carrega a sua, checando **presença de config** (ex.: o Navidrome checa se
`config.sops.templates ? "navidrome.env"`).

Para adicionar uma feature:
1. Criar `modules/<categoria>/<feature>.nix` registrando o(s) aspect(s);
2. `git add` o arquivo (o flake lê o índice do git);
3. Importar na lista do host.

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
