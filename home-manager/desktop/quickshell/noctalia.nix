{ pkgs, inputs, ... }:
{
    imports = [
      inputs.noctalia.homeModules.default
    ];

    home.file.".cache/noctalia/wallpapers.json" = {
      text = builtins.toJSON {
        defaultWallpaper = "${../images/sea.png}";
      };
    };

    # configure options
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "comfortable";
          position = "top";
          barType = "simple";
          outerCorners = true;
          frameRadius = 999;
          useSeperateOpacity = true;
          
          showCapsule = false;
          widgetSpacig = 6;
          contentPadding = 6;
          widgets ={
            left = [
              {
                id = "SystemMonitor";
              }
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
              {
                id = "Tray";
                colorizeIcons = false;
              }
              {
                id = "Taskbar";
                colorizeIcons = false;
              }
              {
                id = "MediaMini";
              }
              {
                id = "AudioVisualizer";
              }
              
              
              
            ];
            center = [
              {
                id = "NotificationHistory";
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Launcher";
              }  
              {
                id = "WallpaperSelector";
              }
              
              
              
              
            ];
            right = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "DarkMode";
              }
              {
                alwaysShowPercentage = false;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                id = "KeepAwake";
              }
              {
                id = "SessionMenu";
              }
              
            ];
          };
        };
        colorSchemes = {
          darkMode = true;
          generationMethod = "tonal-spot";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          monitorForColors = "";
          predefinedScheme = "Nord";
          schedulingMode = "off";
          syncGsettings = true;
          useWallpaperColors = false;
        };
        general = {
          # avatarImage = "/home/drfoobar/.face";	# todo
          radiusRatio = 1.0;  # shape of workspace unit; bar corner
        };
        location = {
          monthBeforeDay = true;
          name = "Marseille, France";
        };
        templates = {
          activeTemplates = [
            {
              enabled = true;
              id = "fuzzel";
            }
          ];
          enableUserTheming = false;
        };
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
