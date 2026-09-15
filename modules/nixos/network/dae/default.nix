{ pkgs, config, inputs, lib, configRoot, ... }:

{
  imports = [
    inputs.daeuniverse.nixosModules.dae
  ];

  services = {
    dae = {
      enable = true;
      configFile = "/etc/dae/config.dae";
    };
  };

  sops.templates."dae-config" = {
    path = "/etc/dae/config.dae";

    owner = "root";
    group = "root";
    mode = "0600";

    content =
      builtins.replaceStrings
      [ "__VPS__" ]
      [ config.sops.placeholder.vultr_vps ]
      (
        builtins.replaceStrings
        [ "__TAPFOG__" ]
        [ config.sops.placeholder.tapfog_link ]
        (builtins.readFile ./config.dae)
      );
  };


  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "daectl" ''
      #!${pkgs.nushell}/bin/nu

      source ${configRoot}/scripts/network/daectl.nu

      def main [option: string] {
        daectl $option
      }
    '')
  ];

  # Keep dae.service available for manual use, but do not start it at boot.
  systemd.services = {
    dae.wantedBy = lib.mkForce [];
  };

  # sudo dae wont need password
  security.sudo.extraRules = [
    {
      users = [ "woc" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl start dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl stop dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl restart dae.service";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl status dae.service";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
