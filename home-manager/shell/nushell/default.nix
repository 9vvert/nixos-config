{pkgs, inputs, lib, ...}:

{

  programs.carapace = {   # shell completions
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;
    
    settings = {
      show_banner = false;
      edit_mode = "emacs";
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
        };
      };
      history = {
        max_size = 10000;
        sync_on_enter = true;
        file_format = "sqlite";
      };
    };
    extraConfig = lib.mkAfter ''
      source ${./init.nu}
      source ${./function.nu}
      source ${./nu-script/proxy.nu}
    '';
  };

  home.packages = with pkgs; [
    nushell
    nufmt   # formatter for nushell
    starship
  ];
}
