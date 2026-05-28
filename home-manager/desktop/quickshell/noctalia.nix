{
  pkgs,
  inputs,
  lib,
  ...
}: let
  noctaliaSettings = {
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
      widgets = {
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
            formatHorizontal = "M.d ddd HH:mm";
            formatVertical = "M.d\nddd\nHH\nmm";
            id = "Clock";
            useMonospacedFont = true;
            usePrimaryColor = true;
          }
          {
            id = "ControlCenter";
            useDistroLogo = true;
          }
          {
            id = "NotificationHistory";
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
      radiusRatio = 1.0; # shape of workspace unit; bar corner
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

  noctaliaSettingsSeed = pkgs.writeText "noctalia-settings-seed.json" (builtins.toJSON noctaliaSettings);
in {
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
    # Noctalia mutates settings.json at runtime. The upstream Home Manager
    # option writes it as a Nix store symlink, which breaks repeated toggles.
    settings = {};
  };

  home.activation.noctaliaSettingsSeed = lib.hm.dag.entryAfter ["writeBoundary"] ''
    settings_dir="$HOME/.config/noctalia"
    settings_file="$settings_dir/settings.json"

    $DRY_RUN_CMD mkdir -p "$settings_dir"

    # If that symlink points into /nix/store, it means Home Manager previously managed it as an immutable Nix-store file.
    if [ -L "$settings_file" ]; then
      target="$(readlink "$settings_file")"
      case "$target" in
        /nix/store/*)
          $DRY_RUN_CMD rm -f "$settings_file"
          $DRY_RUN_CMD cp ${noctaliaSettingsSeed} "$settings_file"
          $DRY_RUN_CMD chmod u+w "$settings_file"
          ;;
      esac
    # otherwise overwrite it.
    else
      $DRY_RUN_CMD cp ${noctaliaSettingsSeed} "$settings_file"
      $DRY_RUN_CMD chmod u+w "$settings_file"
    fi
  '';

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
