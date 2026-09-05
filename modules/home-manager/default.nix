{ pkgs, inputs, ... }:

{
  imports = [
    ./ai
    ./binary
    ./editor
    ./game
    ./media
    ./shell
    ./terminal
    ./desktop
    ./input
    ./program
    ./office
    ./misc
  ];
}