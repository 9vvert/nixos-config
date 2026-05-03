{ ... }:

{
  programs.niri.settings.input = {
    keyboard = {
      numlock = true;
    };
    touchpad = {
      tap = true;
      "natural-scroll" = true;
    };
    mouse = {
      "accel-speed" = 0.2;
      "accel-profile" = "flat";
    };
    trackpoint = {
      "accel-speed" = 0.2;
      "accel-profile" = "flat";
    };
  };
}
