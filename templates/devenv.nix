{ ... }:
{
  imports = [
    # Define o stack base do projeto importando o módulo central do repo de config.
    # Troque pela stack desejada:
    #   /home/kim/.my-nixos-config/devenv/python.nix
    #   /home/kim/.my-nixos-config/devenv/web.nix
    #   /home/kim/.my-nixos-config/devenv/c-cpp.nix
    #   /home/kim/.my-nixos-config/devenv/java.nix
    /home/kim/.my-nixos-config/devenv/python.nix
  ];

  # Overrides específicos do projeto aqui (ex.: JAVA_HOME, packages extras, scripts...).
  # packages = [ pkgs.tree ];

  # enterShell = ''
  #   echo "projeto pronto"
  # '';
}