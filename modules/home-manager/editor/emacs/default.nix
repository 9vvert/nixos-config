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

      ; fix emacs window behavior in niri (https://github.com/niri-wm/niri/issues/2632)
      (setopt frame-inhibit-implied-resize t)
      (setopt frame-resize-pixelwise t)
    '';
  };
}
