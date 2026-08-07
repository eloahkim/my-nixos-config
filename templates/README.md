# Dev environments via devenv 2.x

Cada projeto usa um ambiente `devenv` (arquivos `devenv.nix` + `devenv.yaml`/
`devenv.lock`), que recebe o *stack* via *import* de um módulo central deste
repo. A CLI de `devenv` está instalada no sistema (módulo `system/devenv`).

## Scaffold de um projeto

Copie os arquivos do template para a raiz do projeto:

```bash
$ cp templates/devenv.nix templates/devenv.yaml templates/.envrc templates/.gitignore meu-projeto/
$ cd meu-projeto
$ nvim devenv.nix   # escolha o stack no `imports` (default = python)
$ direnv allow      # carrega o ambiente
```

O `devenv.lock` (pin dos inputs) é gerado na primeira avaliação.

## Stacks de centrais (módulos em `devenv/`)

| Stack            | Módulo central          | Ferramentas                                                          |
| ---------------- | ----------------------- | -------------------------------------------------------------------- |
| Python (uv)      | `devenv/python.nix`     | uv, python3, basedpyright, ruff, black, isort                        |
| Web (JS/PHP)     | `devenv/web.nix`        | nodejs_22, pnpm, TS LSP, prettier, eslint, php, composer, phpactor, sqlite, mariadb-client + `services.mysql` + `processes.www` |
| C/C++            | `devenv/c-cpp.nix`      | clang/clangd, gcc, cmake, ninja, pkg-config, gdb, valgrind, bear     |
| Java (Maven)     | `devenv/java.nix`       | Temurin 21 (`JAVA_HOME`), Maven, jdt-language-server (jdtls p/ eglot)|

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