{ ... }:

{
  programs.niri.settings."spawn-at-startup" = [
    { argv = [ "swaybg" "-i" "/home/woc/Pictures/dawn.png" ]; }
    { argv = [ "qs" "-c" "noctalia-shell" ]; }
  ];
}
