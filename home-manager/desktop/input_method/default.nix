{ config, pkgs, ... }:

{
  # fcitx
  home.file.".config/fcitx5/profile".source = ./fcitx5/profile;
  home.file.".config/fcitx5/config".source = ./fcitx5/config;
  home.file.".config/fcitx5/conf/classicui.conf".source = ./fcitx5/conf/classicui.conf;

  # rime
  home.file.".local/share/fcitx5/rime/default.custom.yaml".source = ./rime/default.custom.yaml;
  home.file.".local/share/fcitx5/rime/terra_pinyin.custom.yaml".source = ./rime/terra_pinyin.custom.yaml;
}