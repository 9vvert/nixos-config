{ pkgs, inputs, lib, ... }:

{
  services = {
    dae = {
      enable = true;
      configFile = "/etc/dae/config.dae";
    };
  };

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
