{ pkgs, inputs, ... }:

let
  treesitterWithParsers = pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers:
    with parsers; [
      asm
      bash
      c
      cmake
      cpp
      go
      java
      javascript
      json
      latex
      llvm
      lua
      make
      markdown
      markdown_inline
      nix
      objdump
      python
      rust
      typescript
      yaml
    ]);
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    nixpkgs.pkgs = pkgs;
    
    enable = true;

    extraPackages = with pkgs; [
      asm-lsp
      ast-grep
      awk-language-server
      clang-tools
      cmake-language-server
      fd
      haskell-language-server
      lua-language-server
      ocamlPackages.ocaml-lsp
      pyright
      ripgrep
      ruby-lsp
      rust-analyzer
      stylua
      typescript-language-server
      yaml-language-server
    ];

    extraPlugins = [ treesitterWithParsers ] ++ (with pkgs.vimPlugins; [
    ]);
  };
}
