{ pkgs, ... }:

let
  base = pkgs.appimageTools.defaultFhsEnvArgs;

  Ida_FhsApp = pkgs.buildFHSEnv (base // {
    # NOTE: this is only a wrapper
    name = "ida9";

    targetPkgs = pkgs:
      (base.targetPkgs pkgs) ++ (with pkgs; [
        qt6.qtbase
        qt6.qtwayland
        qt6.qtsvg

        glib
        dbus
        fontconfig
        freetype
        libGL
        mesa
        libxkbcommon

        xorg.libX11
        xorg.libXext
        xorg.libXrender
        xorg.libXi
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXfixes
        xorg.libxkbfile

        libxcb
        libxcb-util
        libxcb-cursor
        libxcb-image
        libxcb-keysyms
        libxcb-render-util
        libxcb-wm

        zlib
        openssl
        curl
        alsa-lib
        pulseaudio
      ]);

    profile = ''
      export FHS=1
      export QT_QPA_PLATFORM=xcb
    '';

    runScript = pkgs.writeShellScript "run-my-app" ''
      cd /opt/ida9
      QT_QPA_PLATFORM=xcb ./ida
    '';
  });

  Ida_FhsDesktop = pkgs.makeDesktopItem {
    name = "Ida Pro 9";
    desktopName = "Ida Pro 9";
    exec = "${Ida_FhsApp}/bin/ida9";
    icon = "applications-system";
    terminal = false;
    type = "Application";
    categories = [ "Utility" ];
  };

in
{
  home.packages = [
    Ida_FhsApp
    Ida_FhsDesktop
  ];
}