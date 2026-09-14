{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages =with pkgs; [
      libinput
    ];
  };
}