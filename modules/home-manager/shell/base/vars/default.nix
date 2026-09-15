{ ... }:
{
  myshell.base.envVars = {
    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
    PAGER = "less";  
    # wayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # enable these may cause plasma kde failed to start
    # QT_QPA_PLATFORM = "wayland;xcb";
    # WAYLAND_DISPLAY="wayland-1";
    # XDG_CURRENT_DESKTOP="niri";
    # XDG_SESSION_TYPE="wayland";
    
    # for java based program, 
    _JAVA_AWT_WM_NONREPARENTING = "1";

  };
}
