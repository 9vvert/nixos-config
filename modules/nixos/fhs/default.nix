{ pkgs, inputs, ... }:

{
  imports = [
    ./bfhs.nix
    ./zfhs.nix
    ./ld.nix
  ];
}
