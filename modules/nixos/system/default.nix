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
      patchelf
      
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

  # nix-ld

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      
      # My own additions
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libelf

      # Required
      glib
      gtk2

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager      
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM
      
      # # Without these it silently fails
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim
      
      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed
      
      # Verified games requirements
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libidn
      tbb
      
      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs

      # darktable nightly AppImage https://github.com/darktable-org/darktable/releases
      gmp

      # RapidRaw
      harfbuzz
      libgpg-error
      # https://github.com/xournalpp/xournalpp/releases/download/v1.2.4/xournalpp-1.2.4-x86_64.AppImage
      fribidi
      librsvg
      # https://github.com/nix-community/nix-ld/issues/95#issuecomment-3041993870
      (runCommand "librsvg" {} ''
        mkdir -p $out/lib/gdk-pixbuf-2.0/2.10.0/loaders
        ln -s "${librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader_svg.so" "$out/lib/libpixbufloader-svg.so"
      '')

      # pdfmastereditor
      sane-backends
      pkcs11helper

      # Qt6 requires this (e.g. used in zxlive)
      libpulseaudio
      krb5
      libxcb-cursor
      xorg.xcbutilwm
      xorg.xcbutil
      xorg.xcbutilimage
      xorg.xcbutilkeysyms
      xorg.xcbutilrenderutil
      
    ];
  };  
}
