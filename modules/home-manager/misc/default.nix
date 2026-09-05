{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # markdown
    gperf
  ];
}
