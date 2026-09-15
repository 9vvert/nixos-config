{ pkgs, inputs, configRoot, ... }:

{
  environment = {
    systemPackages =with pkgs; [
      age
      sops
    
    ];
  };

  sops.defaultSopsFile = "${configRoot}/secrets/default.yaml";

  sops.secrets.vultr_vps = {};
  sops.secrets.tapfog_link = {};
}