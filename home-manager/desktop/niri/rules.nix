{ ... }:

{
  programs.niri.settings."window-rules" = [
    {
      "geometry-corner-radius" = {
        "top-left" = 20;
        "top-right" = 20;
        "bottom-left" = 20;
        "bottom-right" = 20;
      };
      "draw-border-with-background" = false;
      "clip-to-geometry" = true;
    }
    {
      matches = [
        { "app-id" = "^org\\.wezfurlong\\.wezterm$"; }
      ];
      "default-column-width" = {};
    }
    {
      matches = [
        {
          "app-id" = "firefox$";
          title = "^Picture-in-Picture$";
        }
      ];
      "open-floating" = true;
    }
    {
      matches = [
        { "app-id" = "firefox"; }
        { "app-id" = "chrome"; }
      ];
      "open-maximized" = true;
    }
    {
      matches = [
        { "app-id" = "code"; }
      ];
      "open-maximized" = true;
    }
    {
      matches = [
        { "app-id" = "dolphin"; }
      ];
      "open-floating" = true;
    }
  ];
}
