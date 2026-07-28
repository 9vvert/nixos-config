{pkgs, inputs, ...}:

{
  home.packages = with pkgs; [
    inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
