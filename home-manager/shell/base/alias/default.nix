{ ... }:
{
  myshell.base.cmdAlias = {
    l = "exa";
    ll = "exa -l";
    la = "exa -a";
    lla = "exa -la";
    system-rebuild = "sudo nixos-rebuild switch --flake";
    home-rebuild = "home-manager switch --flake";
    start_proxy = "sudo /run/current-system/sw/bin/systemctl start dae.service";
    stop_proxy = "sudo /run/current-system/sw/bin/systemctl stop dae.service";
    restart_proxy = "sudo /run/current-system/sw/bin/systemctl restart dae.service";
    stat_proxy = "/run/current-system/sw/bin/systemctl status dae.service";
  };
}
