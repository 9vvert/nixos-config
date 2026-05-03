{pkgs, inputs, ...}:

{
  programs.nushell = {
    enable = true;
    
    configFile.text = ''
      $show_banner: false
      edit_mode: vi

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
    '';
  };

  programs.packages = with pkgs; [
    nushell
    nufmt   # formatter for nushell
    starship
  ];
}