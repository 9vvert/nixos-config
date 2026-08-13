{
  pkgs,
  inputs,
  lib,
  configRoot,
  ...
}: let
  fuzzelThemeTemplate = pkgs.writeText "noctalia-fuzzel-template.ini" ''
    [colors]
    background={{colors.surface.default.hex}}dd
    text={{colors.on_surface.default.hex}}ff
    match={{colors.primary.default.hex}}ff
    selection={{colors.surface_container.default.hex}}ff
    selection-text={{colors.on_surface.default.hex}}ff
    selection-match={{colors.primary.default.hex}}ff
    border={{colors.outline.default.hex}}ff
  '';
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      shell = {
        corner_radius_scale = 1.0;
        settings_show_advanced = true;
        app_icon_colorize = false;
        panel = {
          control_center_position = "auto";
          open_near_click_control_center = true;
          launcher_position = "auto";
          open_near_click_launcher = true;
          wallpaper_position = "auto";
          open_near_click_wallpaper = true;
          session_position = "auto";
          open_near_click_session = true;
        };
      };

      wallpaper = {
        directory = "${configRoot}/wallpapers";
        default.path = "${configRoot}/wallpapers/sea.png";

        automation = {
          enabled = true;
          interval_seconds = 1800;
          order = "random"; # or "alphabetical"
          recursive = true;
        };
      };

      theme = {
        mode = "auto";
        source = "wallpaper";
        builtin = "Nord";
        custom_palette = "my-palette";
        wallpaper_scheme = "m3-tonal-spot";
        templates = {
          enable_builtin_templates = true;
          builtin_ids = [
            "gtk3"
            "gtk4"
          ];

          enable_community_templates = false;
          community_ids = [];

          user.fuzzel = {
            enabled = true;
            input_path = "templates/fuzzel.ini";
            output_path = "~/.config/fuzzel/themes/noctalia";
          };
        };
      };

      location = {
        address = "Marseille, France";
        custom_schedule = false;
        sunrise = "06:30";
        sunset = "18:30";
      };

      bar.main = {
        position = "top";
        thickness = 40;
        scale = 1.2;
        background_opacity = 1.0;
        border_width = 0.0;
        margin_ends = 0;
        margin_edge = 0;
        margin_opposite_edge = 0;
        padding = 12;
        widget_spacing = 12;
        radius = 0;
        radius_top_left = 0;
        radius_top_right = 0;
        radius_bottom_left = 18;
        radius_bottom_right = 18;
        concave_edge_corners = true;
        shadow = false;
        capsule = false;
        capsule_padding = 6;
        capsule_radius = 80.0;
        capsule_opacity = 1.0;
        start = [
          "system_monitor"
          "workspaces"
          "tray"
          "taskbar"
          "media_mini"
          "audio_visualizer"
        ];
        center = [
          "clock"
          "control_center"
          "notification_history"
          "launcher"
          
        ];
        end = [
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "wallpaper_selector"
          "dark_mode"
          "battery"
          "keep_awake"
          "session_menu"
        ];
      };

      widget = {
        system_monitor.type = "sysmon";

        workspaces = {
          type = "workspaces";
          display = "none";
          hide_when_empty = false;
        };

        tray = {
          type = "tray";
          drawer = true;
          hidden = [
            "fcitx"
            "fcitx5"
          ];
        };

        taskbar = {
          type = "taskbar";
          only_active_workspace = true;
          group_by_workspace = true;
          show_workspace_label = false;
          workspace_group_capsule = false;
        };

        media_mini = {
          type = "media";
          hide_when_no_media = true;
          min_length = 0;
          max_length = 140;
          title_scroll = "on_hover";
        };

        audio_visualizer = {
          type = "audio_visualizer";

          width = 56;
          bands = 16;

          mirrored = false;
          centered = true;

          show_when_idle = false;
          color_1 = "primary";
          color_2 = "primary";
        };

        clock = {
          type = "clock";
          format = "{:%H:%M}";
          vertical_format = "{:%-m.%-d\n%a\n%H\n%M}";
          color = "primary";
          font_family = "monospace";
        };

        control_center = {
          type = "control-center";
          custom_image = "/run/current-system/sw/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          custom_image_colorize = false;
          scale = 1.25;
        };

        notification_history.type = "notifications";
        launcher.type = "launcher";
        wallpaper_selector.type = "wallpaper";

        network = {
          type = "network";
          show_label = false;
        };

        bluetooth = {
          type = "bluetooth";
          show_label = false;
        };

        volume = {
          type = "volume";
          show_label = false;
          mute_color = "on_surface";
        };

        brightness = {
          type = "brightness";
          show_label = false;
        };

        dark_mode.type = "theme_mode";

        battery = {
          type = "battery";
          show_label = false;
        };

        keep_awake.type = "caffeine";
        session_menu.type = "session";
      };

      battery.warning_threshold = 30;
    };
  };

  xdg.configFile."noctalia/templates/fuzzel.ini".source = fuzzelThemeTemplate;

  # Noctalia v5 keeps user changes such as dark/light mode in local state. Keep
  # that file mutable, but migrate the upstream default wallpaper to the old one.
  home.activation.noctaliaV5MutableState = lib.hm.dag.entryAfter ["writeBoundary"] ''
    state_dir="$HOME/.local/state/noctalia"
    settings_file="$state_dir/settings.toml"

    $DRY_RUN_CMD mkdir -p "$state_dir"

    if [ -f "$settings_file" ]; then
      $DRY_RUN_CMD ${pkgs.perl}/bin/perl -0pi -e 's#path = "/nix/store/[^"]+-noctalia-[^"]*/share/noctalia/assets/noctalia-wallpaper\.png"#path = "${seaWallpaper}"#g' "$settings_file"
    fi
  '';
}
