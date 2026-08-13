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


        # emacs mode
        bindkey -e



        # fzf style
        # Enable completion groups and filename colors.
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no

        # Style fzf-tab.
        zstyle ':fzf-tab:*' fzf-flags \
          --height=70% \
          --layout=reverse \
          --border=rounded \
          --info=inline-right \
          '--prompt=› ' \
          '--pointer=▶' \
          '--marker=✓'

        # key binding
        zstyle ':fzf-tab:*' fzf-bindings \
          'ctrl-u:half-page-up' \
          'ctrl-d:half-page-down' \
          'ctrl-b:page-up' \
          'ctrl-f:page-down' \
          'home:first' \
          'end:last' \
          'ctrl-/:change-preview-window(right,50%|down,40%|hidden)'

        # Ctrl+L: enter the selected directory and immediately complete its children.
        zstyle ':fzf-tab:*' continuous-trigger 'ctrl-l'

        # Switch completion groups with < and >.
        zstyle ':fzf-tab:*' switch-group '<' '>'

        # Show an eza tree when completing directories.
        zstyle ':fzf-tab:complete:cd:*' fzf-preview \
          'eza --tree --level=2 --color=always --icons=always --group-directories-first "$realpath"'

        zstyle ':fzf-tab:complete:*:*' fzf-preview \
          'if [[ -d "$realpath" ]]; then
            eza --tree --level=2 --color=always --icons=always "$realpath"
          else
            file "$realpath"
          fi'



        # activate python venv
        source ~/.venv13/bin/activate
      '';
    };
}
