{ pkgs, ... }:
{
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
  services.mysql.enable = true;
  processes.www.exec = "php -S 127.0.0.1:8080";
}