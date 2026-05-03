{lib, config, ...}:

{
  imports = [
    ./alias
    ./vars
  ];
  options.myshell.base = lib.mkOption {
    envVars = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Environment variables";
    };

    cmdAlias = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Command aliases";
    }
  };

  config = {
    programs.nushell.shellAliases = config.myshell.base.cmdAlias;
    programs.zsh.shellAliases = config.myshell.base.cmdAlias;
    programs.bashshellAliases = config.myshell.base.cmdAlias;
  };
}