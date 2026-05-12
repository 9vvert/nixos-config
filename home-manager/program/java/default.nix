{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # JDK
    jdk21

    # Build tools
    maven
    gradle

    # Language server / editor support
    jdt-language-server

    # Optional tools
    checkstyle
    google-java-format
  ];

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
  };
}