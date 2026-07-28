{ config, pkgs, ... }:

{
  # fcitx
  home.file.".config/fcitx5/profile" = {
    source = ./fcitx5/profile;
    force = true;
  };
  home.file.".config/fcitx5/config" = {
    source = ./fcitx5/config;
    force = true;
  };
  home.file.".config/fcitx5/conf/classicui.conf" = {
    enable = false;
  };

  # rime
  home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
    source = ./rime/default.custom.yaml;
    force = true;
  };
  home.file.".local/share/fcitx5/rime/terra_pinyin.custom.yaml" = {
    source = ./rime/terra_pinyin.custom.yaml;
    force = true;
  };
}
