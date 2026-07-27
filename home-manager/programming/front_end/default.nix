# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Runtime + package manager
    nodejs_22
    pnpm

    # TypeScript
    typescript
    typescript-language-server

    # Formatter / linter
    prettier
    eslint

    # Optional modern runtime
    bun
  ];
}