{ pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
  ];


  # misc software
  environment.systemPackages = with pkgs; [
    # wayland
    wayland-utils
    xwayland-satellite
    wl-clipboard

    # desktop
    swaybg
    fuzzel
  ];

  # misc
  services = {
    xserver.desktopManager.runXdgAutostartIfNone = true;
    desktopManager.plasma6.enable = true;
		displayManager.sddm = {
      enable = true;
			wayland.enable = true;
		};
  };

  # xdg
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      config.niri = {
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  # font
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
          "Maple Mono NF CN"
          "Noto Color Emoji"
        ];

        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
          "Maple Mono NF CN"
          "Noto Color Emoji"
        ];

        monospace = [
          "Maple Mono NF CN"
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK SC"   
          "Noto Color Emoji"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
