# Emacs e projetos no macOS

O `~/.config/emacs` é portátil: ele não importa Nix nem NixOS. O que muda
no macOS é o ambiente externo (Emacs, toolchains e adapters de debug).

## Base

1. Instale Nix (oficial ou Determinate), `git`, `devenv` e `direnv`.
2. Instale o Xcode Command Line Tools:

   ```bash
   xcode-select --install
   ```

3. Instale um Emacs 30 com native-comp e tree-sitter:
   - `emacs-plus@30` (Homebrew ou tap), ou
   - `emacs-mac`.

4. Configure o hook do direnv no shell (`~/.zshrc`):

   ```bash
   eval "$(direnv hook zsh)"
   ```

5. Mantenha o mesmo `~/.config/emacs`. O `straight.el` instala os pacotes
   a partir de `straight/versions/default.el`; não use `package.el`.

## Projetos

O script `scripts/dev-new` funciona igual no macOS e grava o caminho
absoluto do repositório no `devenv.nix` gerado:

```bash
dev-new python meu-projeto
```

Os `devenv.nix` dos projetos podem importar o stack por caminho absoluto:

```nix
imports = [ /Users/kim/.my-nixos-config/devenv/python.nix ];
```

Ou, depois de publicar o repositório, por GitHub:

```yaml
# devenv.yaml
inputs:
  my-nixos:
    url: github:eloahkim/my-nixos-config
```

```nix
{ inputs, ... }:
{
  imports = [ "${inputs.my-nixos.outPath}/devenv/python.nix" ];
}
```

> `devenv container` precisa de um builder Linux; no macOS, use `devenv
> shell`/`direnv` para o dia a dia.

## Debug

- C/C++: use `lldb` no GUD (`C-c C-g`) e `lldb-dap` no `dape` (`C-c C-d`).
  O `gdb` e o `valgrind` não fazem parte do stack no macOS; use `lldb` e
  AddressSanitizer.
- Python: `debugpy` (`C-c C-d`).
- Go: `dlv dap` (`C-c C-d`).
- Java: `jdb` continua sendo o padrão; DAP via `jdtls` + `java-debug` é
  opcional.
- JS/TS e PHP: DAP é opcional (`js-debug`, Xdebug + `php-debug`).

## Diferenças em relação ao Linux

- `gdb`/`valgrind` são substituídos por `lldb`/ASan.
- O compilador nativo do Emacs usa o Xcode CLT.
- O `dape` escolhe `lldb-dap` automaticamente quando `system-type` é
  `darwin`.
- O Emacs roda como GUI standalone; não há daemon/`emacsclient`.
