{ pkgs, inputs, ... }:

{
  imports = [
    ./desktop
    ./network
    ./misc
    ./system
    ./fhs
    ./program
  ];
}
