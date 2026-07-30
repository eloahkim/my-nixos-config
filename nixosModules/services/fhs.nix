{ config, pkgs, lib, ... }:

{
  options.my-nixos.services.fhs.enable = lib.mkEnableOption "Habilitar ambiente FHS";

  config = lib.mkIf config.my-nixos.services.fhs.enable {
    environment.systemPackages = with pkgs; [
      (let base = appimageTools.defaultFhsEnvArgs; in
      buildFHSEnv (base // {
        name = "fhs";

        targetPkgs = pkgs: (base.targetPkgs pkgs) ++ (with pkgs; [
          # Rede
          git wget curl cacert
          # Compilação
          gcc binutils gnumake
          # Runtimes comuns
          python3 nodejs
          # Diagnóstico
          file strace
          # Utilidades já incluídas no original
          pkg-config ncurses
        ]);

        multiPkgs = pkgs: base.multiPkgs pkgs;

        profile = ''
          export FHS=1
          export LANG=C.UTF-8
          export LC_ALL=C.UTF-8
        '';

        runScript = "bash";
      }))
    ];
  };
}
