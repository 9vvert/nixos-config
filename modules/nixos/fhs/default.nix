{ pkgs, inputs, ... }:

{
  imports = [
    ./bfhs
    ./zfhs
    ./ld
  ];
}
