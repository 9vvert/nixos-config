{
  pkgs,
  inputs,
  lib,
  ...
}: {

  home.packages = with pkgs; [
    zinit
  ];

  programs.zsh = {
    enable = true;
  };
}
