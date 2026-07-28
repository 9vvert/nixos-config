{pkgs, ...} :

{
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };
}