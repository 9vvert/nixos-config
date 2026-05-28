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
      add_newline = false;
      line_break.disabled = true;

      format = "$directory [<](yellow)$git_branch[|](yellow)$git_status[>](yellow)\n[\\[](bold green)$username[@](green)$hostname[\\]](bold green)$character";


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

      git_branch = {
        format = "[$branch]($style)";
        style = "bold yellow";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "yellow";
        modified = "M";
        staged = "S";
        untracked = "U";
        ahead = "A";
        behind = "B";
      };

      character = {
        success_symbol = "[>](green) ";
        error_symbol = "[>](red) ";
      };
    };
  };
}
