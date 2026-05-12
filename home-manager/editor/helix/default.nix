{inputs, pkgs, ...}:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        color-modes = true;
        bufferline = "multiple";
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" ];
        }
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };

    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      rust-analyzer
      pyright
      nodePackages.typescript-language-server
    ];
  };
}
