{ ... }:

{
  programs.niri.settings."spawn-at-startup" = [
    { 
      command = ["noctalia-shell"];
    }
    {
      command = ["swaybg" "-i" "~/nixos-config/home-manager/desktop/images/sea.png"];
    }
  ];
}
