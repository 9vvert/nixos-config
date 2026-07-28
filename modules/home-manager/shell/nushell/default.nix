{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.carapace = {
    # shell completions
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

      keybindings = [
        {
          name = "menu_left";
          modifier = "control";
          keycode = "char_h";
          mode = "emacs";
          event = {
            send = "menuleft";
          };
        }

        {
          name = "menu_right";
          modifier = "control";
          keycode = "char_l";
          mode = "emacs";
          event = {
            send = "menuright";
          };
        }

        {
          name = "menu_up";
          modifier = "control";
          keycode = "char_k";
          mode = "emacs";
          event = {
            send = "menuup";
          };
        }

        {
          name = "menu_down";
          modifier = "control";
          keycode = "char_j";
          mode = "emacs";
          event = {
            send = "menudown";
          };
        }

        {
          name = "menu_page_prev";
          modifier = "control";
          keycode = "char_p";
          mode = "emacs";
          event = {
            send = "menupageprevious";
          };
        }

        {
          name = "menu_page_next";
          modifier = "control";
          keycode = "char_n";
          mode = "emacs";
          event = {
            send = "menupagenext";
          };
        }
      ];
    };

    extraConfig = lib.mkAfter ''
      source ${./init.nu}
      source ${./function.nu}
      source ${./nu-script/proxy.nu}
    '';
  };

  home.packages = with pkgs; [
    nushell
    nufmt # formatter for nushell
    starship
  ];
}
