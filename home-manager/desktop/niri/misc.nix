{ ... }:

{
  programs.niri.settings = {
    "hotkey-overlay" = {
      "skip-at-startup" = true;
    };
    "screenshot-path" = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    debug = {
      "honor-xdg-activation-with-invalid-serial" = [];
    };
  };
}
