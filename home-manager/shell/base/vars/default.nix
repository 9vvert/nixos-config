{ ... }:
{
  myshell.base.envVars = {
    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
    PAGER = "less";  
    NIXOS_OZONE_WL = "1";

    # for java based program, 
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
