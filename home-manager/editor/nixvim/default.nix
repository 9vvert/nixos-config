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

  home.file = {
    ".config/nvim/lua/core.lua".source = ./lua/core.lua;
    ".config/nvim/lua/coding.lua".source = ./lua/coding.lua;
    ".config/nvim/lua/navigation.lua".source = ./lua/navigation.lua;
    ".config/nvim/lua/lsp.lua".source = ./lua/lsp.lua;
    ".config/nvim/lua/ui.lua".source = ./lua/ui.lua;
    ".config/nvim/lua/tools.lua".source = ./lua/tools.lua;
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

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
      base16-nvim
      blink-cmp
      bufferline-nvim
      bufdelete-nvim
      codecompanion-nvim
      comment-nvim
      conform-nvim
      copilot-lsp
      copilot-lua
      cyberdream-nvim
      dropbar-nvim
      fidget-nvim
      flash-nvim
      friendly-snippets
      gitsigns-nvim
      lualine-nvim
      midnight-nvim
      neo-tree-nvim
      night-owl-nvim
      nightfox-nvim
      noice-nvim
      nui-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-notify
      nvim-surround
      nvim-web-devicons
      orgmode
      plenary-nvim
      render-markdown-nvim
      statuscol-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      tiny-inline-diagnostic-nvim
      todo-comments-nvim
      trouble-nvim
      which-key-nvim
    ]);

    extraConfigLua = ''
      require("core")
      require("coding")
      require("navigation")
      require("lsp")
      require("ui")
      require("tools")
    '';
  };
}
