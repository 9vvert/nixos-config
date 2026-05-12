# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup

    # editor support
    rust-analyzer

    # native build deps
    gcc
    pkg-config
    openssl
  ];
}