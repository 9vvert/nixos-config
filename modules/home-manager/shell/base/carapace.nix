{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    carapace
  ];

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
    # Carapace's Zsh completers can pass full paths as fzf-tab queries while
    # displaying only basenames, which leaves fzf-tab with zero matches.
    enableZshIntegration = false;
  };
}
