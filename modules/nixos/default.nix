{ pkgs, inputs, ... }:

{
  imports = [
    ./desktop
    ./network
    ./misc
    ./system
    ./virtualization
    ./fhs
    ./program
  ];
}
