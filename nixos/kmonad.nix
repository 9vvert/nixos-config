# modules/kmonad.nix
{ config, pkgs, ... }:

{
  services.kmonad = {
    enable = true;

    keyboards = {
      internal = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";

        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };

        config = ''
          (defsrc
            esc caps
          )

          (deflayer base
            caps (tap-next-press esc lctl)
          )
        '';
      };
    };
  };
}