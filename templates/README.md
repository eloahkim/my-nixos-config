# Dev environments via direnv + Nix

Copie o `.envrc` do stack desejado para a raiz do projeto e rode `direnv allow`.

| Stack          | Arquivo          | Ferramentas                                                       |
| -------------- | ---------------- | ----------------------------------------------------------------- |
| Python (uv)    | `.envrc.python`  | uv, python3, basedpyright, ruff, black, isort                     |
| Web (JS/PHP)   | `.envrc.web`     | nodejs_22, pnpm, TS LSP, prettier, eslint, php, composer, phpactor, sqlite, mariadb-client |
| C/C++          | `.envrc.c-cpp`   | clang/clangd, gcc, cmake, ninja, pkg-config, gdb, valgrind, bear  |

Exemplo:

```console
$ cp templates/.envrc.python meu-projeto/.envrc
$ cd meu-projeto
$ direnv allow
```

Cada projeto carrega o devShell correspondente do flake de config, sem
necessidade de `flake.nix` próprio. Depois que o repo estiver no GitHub, troque
`path:/home/kim/.my-nixos-config` por `github:eloahkim/my-nixos-config`.
