{ pkgs, ... }:

let
  base = pkgs.appimageTools.defaultFhsEnvArgs;

  Ida_FhsApp = pkgs.buildFHSEnv (base // {
    name = "ida9";

    # this is just a wrapper, which will be made a binary under {fhs}/bin
    # then it calls runScript
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

    # set environment, like QT_QPA_PLATFORM
    profile = ''
      export FHS=1
      export QT_QPA_PLATFORM=xcb
    '';

    runScript = pkgs.writeShellScript "run-ida9" ''
      cd /opt/ida9
      exec ./ida "$@"
    '';
  });

  Ida_FhsDesktop = pkgs.makeDesktopItem {
    name = "ida9";
    desktopName = "IDA Professional 9.2";
    exec = "${Ida_FhsApp}/bin/ida9 %F";
    icon = "/opt/ida9/appico.png";
    terminal = false;
    type = "Application";
    categories = [ "Development" "Debugger" ];
  };

in
{
  home.packages = [
    Ida_FhsApp
    Ida_FhsDesktop
  ];
}