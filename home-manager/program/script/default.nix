# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # python
    python313
    uv
    ruff      # linter
    pyright   # lsp

    # lua
    lua5_4
    luarocks  # Lua package manager
    lua-language-server # lsp
    stylua    # formatter
    luacheck  # Linter
  ];
}