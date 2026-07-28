{pkgs, inputs, ...}:

{
  imports = [
    ./ida_pro.nix
  ];
  home.packages = with pkgs; [
    # ida
    
    # ghidra
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ghidra
    
    inputs.pyghidra-mcp.packages.${pkgs.stdenv.hostPlatform.system}.default
    cutter
  ];
}