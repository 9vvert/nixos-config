{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # virtual machine
      qemu
      virtualbox

      # docker
      docker
    ];
  };

  virtualisation.docker.enable = true;

}
