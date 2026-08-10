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

- Rebuild/switch (com diff de closures): `nh os switch`
  - Fallback clássico: `sudo nixos-rebuild switch --flake ~/.my-nixos-config/.#lilith`
- Comparar gerações: `nh diff system-7 system-8`
- Histórico de gerações: `nh log`
- Atualizar inputs: `cd ~/.my-nixos-config && nix flake update`
- Editar secrets: `cd ~/.my-nixos-config/secrets && sops secrets.yaml`

> O `nh` resolve `.#lilith` sozinho via `NH_FLAKE` (exportado em
> `/etc/set-environment` pelo módulo `programs.nh.flake`).

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

## Stack de Nix

Tecnologias do ecossistema Nix usadas nesta config:

| Tecnologia | Uso |
| --- | --- |
| NixOS 26.05 (+ `nixos-unstable`) | sistema base e canal instável; branches pinados no `flake.lock` |
| Nix Flakes | entradas/inputs reproduzíveis a partir do `flake.nix` |
| flake-parts | framework de módulos (perSystem, outputs, sistemas) |
| import-tree | padrão **Dendritic**: um aspecto = um arquivo em `modules/` |
| home-manager | configs de `$HOME` declarativas, acopladas ao host via módulo NixOS |
| sops-nix | segredos cifrados em `secrets/` |
| disko | particionamento declarativo (`hardware/lilith-disko-config.nix`) |
| nh | helper: `nh os switch` com diff de closures + timer `nh-clean` semanal |
| nix-index-database | `command-not-found` com sugestões do store |
| nix-ld | roda binários pré-compilados não-Nix |
| nix-flatpak | flatpaks declarativos (`services/flatpak`) |
| firefox-addons (NUR) | add-ons do Firefox via Nix |
| nixos-hardware | perfil do Lenovo IdeaPad S145 |
| mangowm | compositor Wayland |
| noctalia | launcher/tema (branch `cachix`) |
