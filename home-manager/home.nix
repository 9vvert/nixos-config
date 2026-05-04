# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # inputs.self.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./desktop/niri
    ./desktop/quickshell
    ./terminal
    ./shell
    ./ai/agent
    ./binary_tool
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "woc";
    homeDirectory = "/home/woc";
  };

  # Import files from the current configuration directory into the Nix store,
  # and create symbolic links pointing to those store files in the Home directory.

  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # Import the scripts directory into the Nix store,
  # and recursively generate symbolic links in the Home directory pointing to the files in the store.
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # code/editor
    vscode

    neofetch
    
    yazi

    # archives
    zip
    xz
    unzip
    p7zip
    ghostty
    fuzzel

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder


    # image/video
    loupe
    kdePackages.gwenview


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

    obsidian

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # desktop
    rofi
    zsh

    inputs.quickshell.packages.${pkgs.system}.default
    inputs.codex-cli-nix.packages.${pkgs.system}.default
  ];

  
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings.user = {
      name = "9vvert";
      email = "mzhm803@gmail.com";
    };
    
  };


  # programs.niri = {
  #   enable = true;
  #   # ----------------------------------------------------------------
  #   # ADD THIS BLOCK:
  #   # Overrides the niri derivation to provide the missing XKB paths
  #   # and fix the tests during the build.
  #   # ----------------------------------------------------------------

  #   package = pkgs.niri.overrideAttrs (old: {
  #     nativeCheckInputs = (old.nativeCheckInputs or []) ++ [ pkgs.xkeyboard_config ];
  #     preCheck = (old.preCheck or "") + ''
  #       export XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
  #     '';

  #     # NOTE: If tests STILL fail for some other reason, you can 
  #     # completely skip the testing phase by uncommenting the line below:
  #     # doCheck = false; 
  #   });
  #   settings = {
  #       # ...
  #       spawn-at-startup = [
  #         {
  #           command = [
  #             "noctalia-shell"
  #           ];
  #         }
  #       ];
  #   };
  # };

  # if have already added to configuration.nix, then there is no need to enable there

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default={
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        yzhang.markdown-all-in-one
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/bmp" = ["org.gnome.Loupe.desktop"];
      "image/tiff" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
