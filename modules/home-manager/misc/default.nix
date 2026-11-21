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

    # fun 
    nota

    #
    jekyll

    #
    tigervnc

    # squshfs
    squashfsTools
    sasquatch
    ubi_reader
    ubidump
  ];
}
