{ ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.web = pkgs.mkShell {
      packages = with pkgs; [
        nodejs_22
        pnpm
        typescript-language-server
        prettier
        eslint
        php
        phpPackages.composer
        phpactor
        sqlite
        mariadb.client
      ];
    };
  };
}
