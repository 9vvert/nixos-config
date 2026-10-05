{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    androidsdk
    android-tools
    
  ];
}
