{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    zsh
    nushell
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = "none";
      gtk-titlebar = false;
      window-show-tab-bar = "never";
      theme = "dark:Breeze, light:Breeze";
      # theme = "dark:Abernathy, light:Breeze";
      font-family = "JetBrains Mono";
      background-opacity = 0.85;
      font-size = 11;
      # window padding
      window-padding-x = 8;
      window-padding-y = 8;
      # don't show the resize message
      resize-overlay = "never";
      # keybind
      keybind = [
        "ctrl+o=toggle_tab_overview"
        "shift+enter=text:\x1b\r"
        
      ];
    };
  };
}
