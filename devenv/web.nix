{ pkgs, ... }:
{
  packages = with pkgs; [
    nodejs_22
    pnpm
    typescript
    typescript-language-server
    vscode-langservers-extracted
    prettier
    eslint
    php
    phpPackages.composer
    phpPackages.php-cs-fixer
    phpactor
    sqlite
    mariadb.client
  ];
  services.mysql.enable = true;
  processes.www.exec = "php -S 127.0.0.1:8080";
}