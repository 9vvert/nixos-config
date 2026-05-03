{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    inputs.codex-cli-nix.packages.${pkgs.system}.default
  ];
}