{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    binwalk
    detect-it-easy
    imhex
  ];
}