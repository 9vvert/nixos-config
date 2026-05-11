{
  config,
  lib,
  pkgs,
  ...
}: let
  themeSync = pkgs.writeShellScript "noctalia-theme-sync" ''
    set -eu

    colors_json="$HOME/.config/noctalia/colors.json"
    fuzzel_config="$HOME/.config/fuzzel/fuzzel.ini"
    fcitx_classicui="$HOME/.config/fcitx5/conf/classicui.conf"

    strip_hash() {
      printf '%s' "$1" | sed 's/^#//'
    }

    hex_channel() {
      value="$1"
      start="$2"
      printf '%s' "$value" | cut -c "$start-$((start + 1))"
    }

    luminance() {
      hex="$(strip_hash "$1")"
      r=$((16#$(hex_channel "$hex" 1)))
      g=$((16#$(hex_channel "$hex" 3)))
      b=$((16#$(hex_channel "$hex" 5)))
      echo $(((299 * r + 587 * g + 114 * b) / 1000))
    }

    color() {
      key="$1"
      fallback="$2"
      ${pkgs.jq}/bin/jq -r --arg key "$key" --arg fallback "$fallback" '.[$key] // $fallback' "$colors_json" | sed 's/^#//'
    }

    remove_store_symlink() {
      path="$1"
      if [ -L "$path" ]; then
        target="$(readlink "$path")"
        case "$target" in
          /nix/store/*) rm -f "$path" ;;
        esac
      fi
    }

    apply_theme() {
      [ -r "$colors_json" ] || return 0

      surface="$(color mSurface eceff4)"
      on_surface="$(color mOnSurface 2e3440)"
      on_surface_variant="$(color mOnSurfaceVariant 4c566a)"
      primary="$(color mPrimary 5e81ac)"
      secondary="$(color mSecondary 64adc2)"
      surface_variant="$(color mSurfaceVariant e5e9f0)"
      outline="$(color mOutline c5cedd)"

      if [ "$(luminance "$surface")" -lt 128 ]; then
        fcitx_dark=True
      else
        fcitx_dark=False
      fi

      mkdir -p "$(dirname "$fuzzel_config")" "$(dirname "$fcitx_classicui")"
      remove_store_symlink "$fuzzel_config"
      remove_store_symlink "$fcitx_classicui"

      cat > "$fuzzel_config" <<EOF
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

[colors]
background=''${surface}f2
text=''${on_surface}ff
prompt=''${primary}ff
placeholder=''${on_surface_variant}ff
input=''${on_surface}ff
match=''${primary}ff
selection=''${surface_variant}ff
selection-text=''${on_surface}ff
selection-match=''${secondary}ff
counter=''${on_surface_variant}ff
border=''${outline}ff

[border]
width=1
radius=8
selection-radius=6
EOF

      cat > "$fcitx_classicui" <<EOF
Vertical Candidate List=False
PerScreenDPI=True
Font="Sans 13"
MenuFont="Sans 13"
TrayFont="Sans Bold 10"
Theme=Nord-Light
DarkTheme=Nord-Dark
UseDarkTheme=$fcitx_dark
UseAccentColor=True
EOF

      ${pkgs.fcitx5}/bin/fcitx5-remote -r >/dev/null 2>&1 || true
    }

    apply_theme

    if [ "''${1:-}" = "--once" ]; then
      exit 0
    fi

    while true; do
      if [ -e "$colors_json" ]; then
        ${pkgs.inotify-tools}/bin/inotifywait -q -e close_write,move,create,delete "$(dirname "$colors_json")" >/dev/null 2>&1 || sleep 2
      else
        sleep 2
      fi
      apply_theme
    done
  '';
in {
  home.packages = [
    pkgs.inotify-tools
  ];

  home.activation.noctaliaThemeSync = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${themeSync} --once
  '';

  systemd.user.services.noctalia-theme-sync = {
    Unit = {
      Description = "Sync Noctalia colors to fuzzel and fcitx5";
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${themeSync}";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
