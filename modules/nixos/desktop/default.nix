{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./niri.nix
    ./river.nix
  ];

  # misc software
  environment.systemPackages = with pkgs; [
    # wayland
    wayland-utils
    xwayland-satellite
    wl-clipboard
    wl-screenrec
    libva-utils
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
      extraPortals = [pkgs.xdg-desktop-portal-gtk];

      config.niri = {
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };
  };

  # font
  fonts = {
    # Some native Steam/Unity games scan /usr/share/fonts directly instead of
    # using Fontconfig. Provide the FHS-compatible NixOS font directory.
    fontDir.enable = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      wqy_microhei
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK SC"
          "Noto Sans"
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

      # Add font mapping
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <match target="pattern">
            <test qual="any" name="family">
              <string>Arial</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans CJK SC</string>
              <string>WenQuanYi Micro Hei</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>Liberation Sans</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans CJK SC</string>
              <string>WenQuanYi Micro Hei</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>Microsoft YaHei</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>微软雅黑</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>Microsoft YaHei UI</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>SimHei</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>黑体</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>SimSun</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
              <string>Noto Serif CJK SC</string>
            </edit>
          </match>
          <match target="pattern">
            <test qual="any" name="family">
              <string>宋体</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>WenQuanYi Micro Hei</string>
              <string>Noto Sans CJK SC</string>
              <string>Noto Serif CJK SC</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
