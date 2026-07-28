{ pkgs, inputs, ... }:

{
  imports = [
    ./desktop
    ./network
    ./misc
    ./system
    ./program
  ];
}
