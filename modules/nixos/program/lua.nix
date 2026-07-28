# home.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # lua
    lua5_4
    luarocks  # Lua package manager
    lua-language-server # lsp
    stylua    # formatter
    lua54Packages.luacheck  # Linter
  ];
}