{ pkgs, inputs, ... }:
let
  niriNoNuCompletions =
    inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        rm -f $out/share/nushell/vendor/autoload/niri.nu
      '';
    });
in
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

  programs.niri.package = niriNoNuCompletions;
}
