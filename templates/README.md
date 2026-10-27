# Dev environments via devenv 2.x

Cada projeto usa um ambiente `devenv` (arquivos `devenv.nix` + `devenv.yaml`/
`devenv.lock`), que recebe o *stack* via *import* de um módulo central deste
repo. A CLI de `devenv` está instalada no sistema (módulo `system/devenv`).

## Criar um projeto

O jeito recomendado é usar o script `scripts/dev-new`:

```bash
$ dev-new python meu-projeto
$ dev-new java meu-projeto --package dev.kim.meu
$ dev-new go meu-projeto
$ dev-new c meu-projeto
$ dev-new cpp meu-projeto --cmake
$ dev-new web meu-projeto
$ dev-new web meu-projeto --php
$ dev-new sql meu-projeto --dialect sqlite
```

O script cria o diretório em `~/Projetos`, gera `devenv.nix` já com o
import correto, copia `.envrc`/`devenv.yaml`/`.gitignore`, cria os arquivos
iniciais da stack e roda `direnv allow`. No Python ele também roda
`uv sync`; no SQLite, cria o `app.db`.

Para adicionar o ambiente a um diretório que já existe:

```bash
$ cd ~/Projetos/projeto-existente
$ dev-init python
```

O `dev-init` não sobrescreve arquivos existentes.

Opções úteis:

```text
--here          usa o diretório atual
--package NOME  pacote Java
--module NOME   módulo Go
--dialect SQL   dialeto do sqlfluff (sqlite, postgres, mysql)
--php           adiciona exemplo PHP no template web
--cmake         usa CMakeLists.txt em C/C++
--git           inicializa um repositório Git
--no-sync       não roda uv sync/sqlite3
--no-direnv     não roda direnv allow
--open          abre o arquivo principal no $EDITOR
```

Se o comando `dev-new` não estiver no `PATH`, crie os links:

```bash
ln -sfn ~/.my-nixos-config/scripts/dev-new ~/.local/bin/dev-new
ln -sfn ~/.my-nixos-config/scripts/dev-init ~/.local/bin/dev-init
```

### Alternativa manual

Copie os arquivos do template para a raiz do projeto:

```bash
$ cp templates/devenv.nix templates/devenv.yaml templates/.envrc templates/.gitignore meu-projeto/
$ cd meu-projeto
$ $EDITOR devenv.nix   # escolha o stack no `imports` (default = python)
$ direnv allow         # carrega o ambiente
```

O `devenv.lock` (pin dos inputs) é gerado na primeira avaliação.

## Stacks de centrais (módulos em `devenv/`)

| Stack            | Módulo central          | Ferramentas                                                          |
| ---------------- | ----------------------- | -------------------------------------------------------------------- |
| Python (uv)      | `devenv/python.nix`     | uv, python3, basedpyright, ruff, black, isort, debugpy, pytest       |
| Web (JS/PHP)     | `devenv/web.nix`        | nodejs_22, pnpm, typescript, TS LSP, vscode-langservers (HTML/CSS), prettier, eslint, php, composer, php-cs-fixer, phpactor, sqlite, mariadb-client + `services.mysql` + `processes.www` |
| C/C++            | `devenv/c-cpp.nix`      | clang/clangd, gcc, cmake, ninja, pkg-config, bear, lldb/lldb-dap; gdb/valgrind só no Linux |
| Java (Maven)     | `devenv/java.nix`       | Temurin 21 (`JAVA_HOME`), Maven, jdt-language-server (jdtls p/ eglot)|
| Go               | `devenv/go.nix`         | go, gopls, delve, gotools (goimports), golangci-lint                  |
| SQL              | `devenv/sql.nix`        | sqls, sqlfluff, sqlite, postgresql (psql), mariadb-client (mysql)     |

## Debug

O Emacs usa `dape` para C/C++ (`gdb`/`lldb-dap`), Python (`debugpy`) e Go
(`dlv`). Java continua com `jdb`; DAP em Java/JS/PHP é opcional. O GUD
fica como fallback em `C-c C-g`.

## macOS

O mesmo `~/.config/emacs` roda no macOS; as diferenças de toolchain e
debug estão em [`docs/macos.md`](../docs/macos.md).

## Workflow

```bash
devenv shell      # entra numa shell com o ambiente
devenv up         # sobe services.* e processes.* (ex.: web = mysql + php -S)
devenv test       # roda o enterTest
devenv update     # atualiza o devenv.lock
direnv reload     # reexporta o PATH (p/ LSPs/formatadores no Emacs)
```

## Via Git

Depois do push, troque o caminho absoluto do `imports` por uma referência ao
GitHub para tornar o `devenv.nix` portátil entre máquinas:
`github:eloahkim/my-nixos-config/devenv/python.nix` (via input do `devenv.yaml`).

> Nota: os antigos devShells (`modules/dev/*.nix`, carregados com `use flake`)
> foram substituídos por este fluxo devenv.