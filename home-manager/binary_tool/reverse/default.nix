{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    # ghidra
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.ghidra
    
    inputs.pyghidra-mcp.packages.${pkgs.system}.default
    cutter
  ];
}