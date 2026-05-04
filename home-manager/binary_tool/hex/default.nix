{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    binwalk
  ];
}