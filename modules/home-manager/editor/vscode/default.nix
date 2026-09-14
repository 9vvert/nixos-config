{pkgs, inputs, lib, ...}:

{
  programs.vscode = {
    enable = true;
    profiles.default={
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        yzhang.markdown-all-in-one
      ];

      userSettings = {
        "window.restoreWindows" = "none";
        "[python]" = {
          "diffEditor.ignoreTrimWhitespace" = false;
          "editor.defaultColorDecorators" = "never";
        };
      };
    };
  };

  # xdg.configFile."Code/User/settings.json" = {
  #   force = true;
  # };

#  home.file = {
#     ".config/Code/User/settings.json".force = true;
#   }; 

}