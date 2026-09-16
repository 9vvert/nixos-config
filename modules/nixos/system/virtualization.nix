{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # virtual machine
      qemu
      virtualbox
      vmware-workstation

      # docker
      docker
    ];
  };

  virtualisation.docker.enable = true;

}
