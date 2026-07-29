{ lib, pkgs, inputs, ... }:

{
  imports = [
    ./kmonad.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  programs = {

    firefox = {
      enable = true;
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
      ];
    };
  };

  # turn off "doc", to prevent bulild failure of python312
  environment.extraOutputsToInstall = lib.mkForce [ "man" "info" ];
}
