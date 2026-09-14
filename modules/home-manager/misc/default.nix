{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # markdown
    gperf

    # wiki
    wiki-js

    # 
    nota
  ];
}
