{ ... }:

{
  programs.niri.settings."spawn-at-startup" = [
    { 
      command = ["noctalia-shell"];
    }
    {
      command = ["swaybg" "-i" "../images/sea.png"]
    }
  ];
}
