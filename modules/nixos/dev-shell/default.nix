{ pkgs ? import <nixpkgs> {} }:

  pkgs.mkShell {
    packages = with pkgs; [
      zig_0_16
      pkg-config
      wayland
      wayland-scanner
      wayland-protocols
      linuxHeaders
    ];
  }