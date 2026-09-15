{ pkgs, inputs,... }:

{
  environment = {
    systemPackages =with pkgs; [
      age
      sops
    
    ];
  };

  sops.defaultSopsFile = ./secrets/default.yaml;

  sops.secrets.vultr_vps = {};
  sops.secrets.tapfog_link = {};
}