{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # markdown
    typora
    glow
  ];
}
