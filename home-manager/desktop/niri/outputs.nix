{ ... }:

{
  programs.niri.settings.outputs = {
    "eDP-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 120.030;
      };
      scale = 1.25;
      transform = {
        rotation = 0;
        flipped = false;
      };
      position = {
        x = 1280;
        y = 0;
      };
    };
    "HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.0;
      };
    };
  };
}
