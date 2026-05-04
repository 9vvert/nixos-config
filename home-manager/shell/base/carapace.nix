{inputs, pkgs, ... }:
{
  myshell.base.cmdAlias = {
    l = "exa";
    ll = "exa -l";
    la = "exa -a";
    lla = "exa -la";
    system-rebuild = "sudo nixos-rebuild switch --flake";
    home-rebuild = "home-manager switch --flake";
    proxy_start = "sudo systemctl start dae";
    proxy_stop = "sudo systemctl stop dae";
    proxy_restart = "sudo systemctl restart dae";
  };
}
