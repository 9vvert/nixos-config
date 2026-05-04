{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    ghidra
    cutter
  ];
}