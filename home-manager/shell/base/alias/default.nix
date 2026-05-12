{ ... }:
{
  myshell.base.cmdAlias = {
    l = "exa";
    ll = "exa -l";
    la = "exa -a";
    lla = "exa -la";
    system-rebuild = "sudo nixos-rebuild switch --flake";
    home-rebuild = "home-manager switch --flake";
    start_proxy = "sudo systemctl start dae";
    stop_proxy = "sudo systemctl stop dae";
    restart_proxy = "sudo systemctl restart dae";
    stat_proxy = "sudo systemctl restart dae";
  };
}
