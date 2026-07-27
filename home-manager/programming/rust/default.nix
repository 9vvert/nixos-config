# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustup  # including rust-analyzer, cargo, ...

    # # editor support
    # rust-analyzer

    # native build deps
    gcc
    pkg-config
    openssl
  ];
}