{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
}