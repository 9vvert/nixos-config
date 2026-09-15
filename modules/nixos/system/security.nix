{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages =with pkgs; [
      age
    ];
  };
}