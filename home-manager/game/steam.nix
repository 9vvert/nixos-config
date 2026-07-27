{pkgs, inputs, ...}:

{
  programs.steam = {
    enable = true; 
    remotePlay.openFirewall = true;  # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  home.packages = with pkgs; [
    steam
  ];
}