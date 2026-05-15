{inputs, pkgs, ...}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;  
    
    extraConfig = ''
      (setq inhibit-startup-screen t)   ; disable welcom message
      (setq standard-indent 2)
      (setq make-backup-files nil)      ; disable xxx.txt~ 
      (setq auto-save-default nil)      ; disable #xxx.txt#
      (global-display-line-numbers-mode 1)  ; enable line number
    '';
  };
}
