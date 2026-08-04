{
  pkgs,
  inputs,
  lib,
  ...
}: {

  home.packages = with pkgs; [
    zinit
    fzf
    zoxide
  ];

  programs.zsh = {
      enable = true;

      initContent = lib.mkOrder 900 ''
        # Initialize the Nix-installed Zinit.
        source ${pkgs.zinit}/share/zinit/zinit.zsh

        # Register Zinit completion because Home Manager runs compinit earlier.
        autoload -Uz _zinit
        (( ''${+_comps} )) && _comps[zinit]=_zinit

        zinit light Aloxaf/fzf-tab
        zinit light zsh-users/zsh-autosuggestions
        zinit light zdharma-continuum/fast-syntax-highlighting

        # init zoxide plugin
        eval "$(zoxide init zsh)"
      '';
    };
}
