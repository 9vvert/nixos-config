{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    river

    pkg-config
    wayland
    wayland-protocols

    foot
  ];

  # services.displayManager.sessionPackages = [
  #   pkgs.river
  # ];
}