{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    river

    pkg-config
    wayland
    wayland-scanner
    wayland-protocols

    foot
  ];

  # services.displayManager.sessionPackages = [
  #   pkgs.river
  # ];
}