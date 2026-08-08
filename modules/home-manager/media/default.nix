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
    playerctl # MediaMini need this?
    pulseaudio

    # 
    telegram-desktop
    wechat
    discord
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
