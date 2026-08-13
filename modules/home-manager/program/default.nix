{pkgs, ...} :

{
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };

  programs.packages = with pkgs; [
    lazygit

  ];
}