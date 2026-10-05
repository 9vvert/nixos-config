{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages =with pkgs; [
      libseccomp

      SDL2
      
    ];
  };


}