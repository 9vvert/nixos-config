{ pkgs, inputs, ... }:

{
  imports = [
    ./dae.nix
  ];

  environment.systemPackages = with pkgs; [
    clash-verge-rev
  ];

  networking = {
    hostName = "nixos";
		networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "1.1.1.1" "223.5.5.5" "130.161.158.4" "130.161.33.17" ];
	};

}
