{ lib, pkgs, inputs, configRoot, ... }:
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
      # prevent the env var poison by feishu
      # just unset LD_LIBRARY_PATH is NOT enough
      package = firefox152Pkgs.firefox.overrideAttrs (old: {
        makeWrapperArgs =
          [
            "--unset" "LD_LIBRARY_PATH"
            "--unset" "LD_PRELOAD"
            "--unset" "NIX_LD"
            "--unset" "NIX_LD_LIBRARY_PATH"
          ]
          ++ (old.makeWrapperArgs or []);
      });
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


  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "L" ''
      #!${pkgs.nushell}/bin/nu

      source ${configRoot}/scripts/misc/launch.nu

      def main [...args: string] {
        launch ...$args
      }
    '')

  ];
}
