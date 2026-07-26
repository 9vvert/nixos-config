{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    nethack
    angband
    tome4
    steam
  ];
}
