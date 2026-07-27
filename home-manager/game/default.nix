{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    nethack
    angband
    cataclysm-dda

    # steam related
    protonup-qt
    protontricks
    mangohud
    gamescope

    # minecraft
    prismlauncher
  ];
}
