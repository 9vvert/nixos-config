{pkgs, inputs, ...}:

{
  programs.nushell = {
    enable = true;
    
    configFile.text = ''
      $env.config = {
        show_banner: false
        edit_mode: emacs

        history: {
          max_size: 10000
          sync_on_enter: true
          file_format: "sqlite"
        }

        completions: {
          quick: true
          partial: true
          algorithm: "fuzzy"
        }
      }
    '';
  };

  home.packages = with pkgs; [
    nushell
    nufmt   # formatter for nushell
    starship
  ];
}