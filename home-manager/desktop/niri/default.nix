{ pkgs, inputs, ... }:

{
  imports = [
    # if there is no inputs.noctalia.homeModules.default, it need to be imported in home.nix
    inputs.noctalia.homeModules.default
    ./input.nix
    ./outputs.nix
    ./layout.nix
    ./startup.nix
    ./keybinds.nix
    ./rules.nix
    ./misc.nix
  ];

  programs.niri.enable = true;
}