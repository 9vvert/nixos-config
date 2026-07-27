{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    nethack
    angband

    # steam related
    protonup-qt
    protontricks
    mangohud
    gamescope
  ];
}
