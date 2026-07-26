{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    nethack
  ];
}
