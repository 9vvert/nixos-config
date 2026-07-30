{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # basic
      busybox    
      wget
      curl
      gcc
      git 
      
      # editor
      vim
      neovim
      
      #
      google-chrome  
      fastfetch
      home-manager

      # archive
      zip
      xz
      unzip
      p7zip

      # filter utils
      ripgrep
      fd
      jq 
      yq-go 
      eza 
      fzf

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg

      # Create FHS environment
      (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
        pkgs.buildFHSEnv (base // {
        name = "fhs";
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
    variables.EDITOR = "vim";
  };

  services = {
    openssh.enable = true;
  };
}
