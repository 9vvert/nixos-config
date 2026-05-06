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
        colorSchemes.predefinedScheme = "Nord";
        general = {
          # avatarImage = "/home/drfoobar/.face";	# todo
          radiusRatio = 1.0;  # shape of workspace unit; bar corner
        };
        location = {
          monthBeforeDay = true;
          name = "Marseille, France";
        };
      };
  };
}
