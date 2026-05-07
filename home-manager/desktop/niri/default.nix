{ pkgs, inputs, ... }:

{
  imports = [
    # if there is no inputs.niri.homeModules.niri, it need to be imported in home.nix
    inputs.niri.homeModules.niri
    ./input.nix
    ./outputs.nix
    ./layout.nix
    ./startup.nix
    ./keybinds.nix
    ./rules.nix
    ./blur.nix
    ./misc.nix
  ];

  programs.niri = {
    enable = true; # already defined in inputs.niri.homeModules.niri
    # use niri-unstable (to enable blur)
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };

  home.packages = with pkgs; [
    swaybg
    fuzzel
    wl-clipboard
    ghostty
  ];
}
