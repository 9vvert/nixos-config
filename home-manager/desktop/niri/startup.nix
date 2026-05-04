{ pkgs, ... }:

{
  programs.niri.settings."spawn-at-startup" = [
    { 
      command = ["noctalia-shell"];
    }
    {
      # wrong: command = ["swaybg" "-i" "~/nixos-config/home-manager/desktop/images/sea.png"];
      # use ${} because it is in nushell
      command = ["${pkgs.swaybg}/bin/swaybg" "-i" "${../images/sea.png}" "-m" "fill"];
    }
  ];
}
