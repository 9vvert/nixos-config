{ lib, pkgs, inputs, ... }:
let
  firefox152Pkgs = import inputs.nixpkgs25_11 {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./kmonad.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {

    firefox = {
      enable = true;
      package = firefox152Pkgs.firefox;
      policies = {
        DisableAppUpdate = true;
        Proxy = {
          Mode = "none";
          Locked = true;
        };
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        libGLU
      ];
    };
  };

  # turn off "doc", to prevent bulild failure of python312
  environment.extraOutputsToInstall = lib.mkForce [ "man" "info" ];
}
