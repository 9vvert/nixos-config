{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    pwntools
    ropr
    ropgadget
  ];
}