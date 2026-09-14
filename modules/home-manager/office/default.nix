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

    #
    feishu
    feishu-cli
  ];
}
