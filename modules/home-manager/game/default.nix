{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    # classic roguelike
    nethack
    angband
 
    # CDDA
    cataclysmDDA.stable.tiles
    cataclysmDDA.stable.curses

    # steam related
    protonup-qt
    protontricks
    mangohud
    gamescope

    # minecraft
    prismlauncher

    # emulator
    snes9x
  ];
}
