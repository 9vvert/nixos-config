{ pkgs, inputs, nixpkgs, ... }:

{
  home.packages = with pkgs; [
    androidsdk
    android-tools

  ];

  # accept android-sdk-license
  nixpkgs.config = {
    android_sdk.accept_license = true;
  };
}
