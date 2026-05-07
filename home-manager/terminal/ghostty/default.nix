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
      window-show-tab-bar = "never";
      theme = "dark:Abernathy, light:Breeze";
      font-family = "JetBrains Mono";
      background-opacity = 0.85;
      font-size = 11;
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