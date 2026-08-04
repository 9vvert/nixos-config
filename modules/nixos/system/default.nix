{ pkgs, inputs, ... }:

{
  imports = [
    ./cross.nix
    ./virtualization.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # basic
      busybox    
      wget
      curl
      gcc
      git 
      patchelf
      nix-index

      # 
      zsh
      nushell
      
      
      # editor
      vim
      neovim
      
      #
      google-chrome  
      fastfetch
      home-manager

      # archive
      zip
      xz
      unzip
      p7zip

      # filter utils
      ripgrep
      fd
      jq 
      yq-go 
      eza 
      fzf

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
    ];
    variables.EDITOR = "vim";
  };

  services = {
    openssh.enable = true;
  };

  programs.zsh.enable = true;

}
