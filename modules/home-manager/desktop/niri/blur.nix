{ config, inputs, lib, ... }:

let
  niriSettings = import "${inputs.niri}/settings.nix" {
    inherit inputs lib;
    inherit (inputs.niri.lib) kdl;
    docs = null;
    binds = null;
    settings = null;
  };
in
{
  programs.niri.config = lib.mkForce ''
    ${inputs.niri.lib.kdl.serialize.nodes (niriSettings.render config.programs.niri.settings)}

    blur {
        passes 2
        offset 2
        noise 0.02
        saturation 1.2
    }

    window-rule {
        background-effect {
            blur true
        }
    }

  '';
}
