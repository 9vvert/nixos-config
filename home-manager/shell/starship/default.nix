{...}:
# starship - an customizable prompt for any shell
{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    # custom settings
    settings = {
      add_newline = true;
      line_break.disabled = true;

      format = "$directory( [<](red)$git_branch$git_status[>](red))([\(](purple)\${custom.shell}\${custom.fhs}[\)](purple))\n[\\[](bold green)$username[@](green)$hostname[\\]](bold green)$character";

      git_branch = {
        format = "[$branch]($style)";
        style = "bold red";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "red";
      };
      directory = {
        format = "[$path]($style)";
        style = "bold cyan";
        truncate_to_repo = false;
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold green";
        style_root = "bold red";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style)";
        style = "bold green";
      };

      character = {
        success_symbol = "[>](green)";
        error_symbol = "[>](red)";
      };
      # shell detect
      custom.shell = {
          shell = ["sh" "-s"];
          when = ''[ -n "$STARSHIP_SHELL" ]'';
          command = ''printf '%s' "$STARSHIP_SHELL"'';
          format = "[ $output]($style)";
          style = "purple";
      };


      # fhs detect
      custom.fhs = {
         shell = ["sh" "-s"];
        when = ''test "$FHS" = 1'';
        command = "printf '|FHS'";
        format = "[ $output]($style)";
        style = "purple";
      };

      # venv
      custom.venv = {
        shell = ["sh"];
        when = ''test "$VIRTUAL_ENV" = 1'';
        command = "printf '(FHS)'";
        format = "[ $output]($style)";
        style = "purple";
      };
    };
  };
}
