# home.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # python
    python312
    python313
    python314
    
    uv
    ruff      # linter
    pyright   # lsp

  ];
}