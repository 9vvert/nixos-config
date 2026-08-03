{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Create FHS environment
      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSEnv (base // {
        name = "bfhs";
        targetPkgs = pkgs:
          # pkgs.buildFHSEnv provides only a minimal FHS environment,
          # lacking many basic packages needed by most software.
          # Therefore, we need to add them manually.
          #
          # pkgs.appimageTools provides basic packages required by most software.
          (base.targetPkgs pkgs) ++ (with pkgs; [
            pkg-config
            ncurses
            # Feel free to add more packages here if needed.
            # Qt runtime
            qt6.qtbase
            qt6.qtwayland
            qt6.qtsvg

            # Common GUI/runtime libs
            glib
            dbus
            fontconfig
            freetype
            libGL
            mesa
            
            # xrog
            libXext
            libXrender
            libxcb
            libXi
            libXcursor
            libXrandr
            libXfixes
            libxkbfile
            libxkbcommon

            # Qt xcb platform plugin dependencies
            libxcb
            libxcb-util
            libxcb-cursor
            libxcb-image
            libxcb-keysyms
            libxcb-render-util
            libxcb-wm

            # Often useful
            zlib
            openssl
            curl
            alsa-lib
            pulseaudio
          ]
        );
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = ["dev"];
      }))
  ];
}