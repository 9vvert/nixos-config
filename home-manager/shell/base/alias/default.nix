{}:
{
  myshell.base.cmdAlias = {
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";
    system-rebuild = "sudo nixos-rebuild switch --flake";
    home-rebuild = "home-manager switch --flake";
    proxy_start = "sudo systemctl start dae";
    proxy_stop = "sudo systemctl stop dae";
    proxy_restart = "sudo systemctl restart dae";
  };
}