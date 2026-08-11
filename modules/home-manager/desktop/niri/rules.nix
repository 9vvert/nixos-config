{ ... }:

{
  programs.niri.settings."window-rules" = [
    {
      "geometry-corner-radius" = {
        "top-left" = 8.0;
        "top-right" = 8.0;
        "bottom-left" = 8.0;
        "bottom-right" = 8.0;
      };
      "draw-border-with-background" = false;
      "clip-to-geometry" = true;


      # # fontsize + monospace -> a line with height: 46px, 874 = 46*19
      # "min-height" = 874;
      # "max-height" = 874;

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
