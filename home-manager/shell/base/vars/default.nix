{ ... }:
{
  myshell.base.envVars = {
    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
    PAGER = "less";  
    GTK_IM_MODULE = "";   # in wayland, it is recommend to use QT_IM_MODULE = "fcitx" instead
  };
}
