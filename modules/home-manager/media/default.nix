{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # image/video
    # loupe # ?
    kdePackages.gwenview
    qqmusic
    playerctl   # MediaMini need this? 
  ];
}