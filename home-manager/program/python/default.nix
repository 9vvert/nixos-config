# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python313
    uv
    ruff      # linter
    pyright   # lsp
  ];
}