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
    # Here we use our overide version of niri to prevent the generation of niri.nu, 
    # which will result in some "niri help" command mixed in our nushell fuzzy completion.
    package = inputs.niriNoNuCompletions;
  };

  home.packages = with pkgs; [
    swaybg
    fuzzel
    wl-clipboard
    ghostty
  ];
}
