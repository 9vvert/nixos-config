{ ... }:
{
  myshell.base.cmdAlias = {
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";
    system-rebuild = "sudo nixos-rebuild switch --flake";
    home-rebuild = "home-manager switch --flake";
  };
}
