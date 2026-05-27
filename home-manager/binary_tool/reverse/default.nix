{pkgs, inputs, ...}:

{
  imports = [
    ./ida_pro.nix
  ];
  home.packages = with pkgs; [
    # ida
    
    # ghidra
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.ghidra
    
    inputs.pyghidra-mcp.packages.${pkgs.system}.default
    cutter
  ];
}