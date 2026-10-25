{ pkgs, ... }:
{
  packages = with pkgs; [
    sqls
    sqlfluff
    sqlite
    postgresql
    mariadb.client
  ];
}
