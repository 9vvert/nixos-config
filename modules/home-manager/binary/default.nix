{pkgs, inputs, ...}:

{
  imports = [
    ./hex
    ./debug
    ./reverse
    ./pwn
  ];
}