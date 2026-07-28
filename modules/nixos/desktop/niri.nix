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

  programs.niri = {
    enable = true;
    package = niriNoNuCompletions;
  };
}
