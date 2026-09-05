{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # image/video
    # loupe # ?
    kdePackages.gwenview
    qqmusic
    netease-cloud-music-gtk
    playerctl # MediaMini need this?
    pulseaudio

    mpv

    # 
    telegram-desktop
    wechat
    discord

    # 
    kazumi
    # animeko

    bilibili
    bilibili-tui

    freetube  # youtube
  ];

  imports = [
    inputs."qqmusic-mpris-bridge".homeModules.default
  ];

  services.qqmusic-mpris-bridge = {
    enable = true;
    artSources = [ "qqmusic" ];
    fallbackInterval = 30;
    debounceMs = 350;
    noctaliaPreference = true;
  };
}
