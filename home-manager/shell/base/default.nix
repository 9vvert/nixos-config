{lib, config, ...}:

{
  imports = [
    ./alias
    ./vars
  ];
  options.myshell.base = {
    envVars = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Environment variables";
    };

    cmdAlias = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Command aliases";
    };
  };

  config = {
    home.sessionVariables = config.myshell.base.envVars;
    programs.nushell.shellAliases = config.myshell.base.cmdAlias;
    programs.zsh.shellAliases = config.myshell.base.cmdAlias;
    programs.bash.shellAliases = config.myshell.base.cmdAlias;
  };
}