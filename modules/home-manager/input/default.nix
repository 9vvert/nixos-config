{ config, pkgs, ... }:
{
  imports = [
    ./input_method
  ];


  # input method
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.waylandFrontend = true;
      fcitx5.addons = with pkgs; [
        # fcitx5-gtk
        fcitx5-rime
        qt6Packages.fcitx5-configtool
        fcitx5-rime

        fcitx5-nord 
        fcitx5-rose-pine
        fcitx5-material-color
      ];
    };
  };
}