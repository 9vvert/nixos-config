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

      format = "$username@$hostname$git_branch$git_status$character";

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
        format = " [$branch]($style)";
        style = "bold yellow";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold red";
      };

      character = {
        success_symbol = "[ >](bold green)";
        error_symbol = "[ >](bold red)";
      };
    };
  };
}
