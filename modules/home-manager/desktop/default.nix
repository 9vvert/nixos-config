{ pkgs, inputs, ... }:

{
  imports = [
    ./quickshell
    ./niri
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/bmp" = ["org.gnome.Loupe.desktop"];
      "image/tiff" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      # set default browser
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  xdg.configFile."fuzzel/fuzzel.ini" = {
    force = true;
    text = ''
      include=~/.config/fuzzel/themes/noctalia

      [main]
      font=Sans:size=13
      dpi-aware=auto
      terminal=ghostty -e
      prompt="> "
      icons-enabled=yes
      fields=filename,name,generic,keywords
      width=42
      lines=12
      horizontal-pad=18
      vertical-pad=12
      inner-pad=8
      layer=overlay

      [border]
      width=1
      radius=8
      selection-radius=6
    '';
  };
}
