{ ... }:
{
  myshell.base.envVars = {
    EDITOR = "vim";
    VISUAL = "vim";
    BROWSER = "firefox";
    TERMINAL = "ghostty";
    PAGER = "less";  
    # wayland
    WAYLAND_DISPLAY="wayland-1";
    XDG_CURRENT_DESKTOP="niri";
    XDG_SESSION_TYPE="wayland";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";

    # for java based program, 
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
