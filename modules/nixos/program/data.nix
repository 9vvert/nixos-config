# home.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # JSON
    jq
    jless
    fx

    # YAML / JSON / XML / TOML query/edit
    yq-go
    dasel

    # TOML
    taplo

    # CSV / TSV
    qsv

    # format / lint
    prettier

    # language servers
    yaml-language-server
    vscode-langservers-extracted
  ];
}