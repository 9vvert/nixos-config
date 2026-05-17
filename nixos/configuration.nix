# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # inputs.self.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ./kmonad.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # mirror
      substituters = [
        # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    # Opinionated: disable channels
    channel.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [ vim neovim git google-chrome wget gcc
      wayland-utils fastfetch python314 lua zed xwayland-satellite
      wl-clipboard clash-verge-rev telegram-desktop
      home-manager kmonad
    ];
    variables.EDITOR = "vim";
  };

  boot.loader = {
    timeout = 30;
    grub = {
      enable = true;
	    device = "nodev";
	    efiSupport = true;
	    useOSProber = true;
	    extraEntries = ''
        menuentry "Arch Linux" {
          chainloader (hd0,gpt3)/efi/ARCH/grubx64.efi
          boot
        }
	    '';
	  };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
		};
  };

  # network
  networking = {
    hostName = "nixos";
		networkmanager.enable = true;
	};

  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";

  #  keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    xserver.desktopManager.runXdgAutostartIfNone = true;
    desktopManager.plasma6.enable = true;
		displayManager.sddm = {
      enable = true;
			wayland.enable = true;
		};
    # Enable CUPS to print documents.
    printing.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    openssh.enable = true;
    dae = {
      enable = true;
      configFile = "/etc/dae/config.dae";
    };
	};

  # Keep dae.service available for manual use, but do not start it at boot.
  systemd.services = {
    dae.wantedBy = lib.mkForce [];
  };

  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        Proxy = {
          Mode = "none";
          Locked = true;
        };
      };
    };

    niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
    };
  };

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    woc = {
      shell = pkgs.nushell;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # Highly recommended for screen sharing / portals on Wayland:
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    config.niri = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };


  # input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      # fcitx5-gtk
      fcitx5-rime
      qt6Packages.fcitx5-configtool
      fcitx5-rime

      fcitx5-nord 
      fcitx5-rose-pine
      fcitx5-material-color
    ];
  };


  security.sudo.extraRules = [
  {
    users = [ "woc" ];
    commands = [
        {
          command = "/run/current-system/sw/bin/systemctl start dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl stop dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl restart dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl status dae.service";
          options = [ "NOPASSWD" ];
        }
    ];
  }
];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #home-rebuild .#woc -b backup
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
