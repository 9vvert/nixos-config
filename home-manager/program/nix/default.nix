{pkgs, ...}:

{
  home.packages = with pkgs;[
    nil
    nixd
    statix # Lints and suggestions for the nix programming language
    deadnix # Find and remove unused code in .nix source files
    nixfmt # Nix Code Formatter
  ];
}