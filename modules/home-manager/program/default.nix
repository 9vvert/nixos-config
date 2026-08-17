{pkgs, ...} :

{
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };

  home.packages = with pkgs; [
    lazygit

  ];
}