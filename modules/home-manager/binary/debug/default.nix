{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    gdb
    gef
    inputs.pwndbg.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}