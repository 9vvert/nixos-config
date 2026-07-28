# home.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Runtime + package manager
    nodejs_22
    pnpm

    # TypeScript
    typescript
    # typescript-language-server # removed in 26.05

    # Formatter / linter
    prettier
    eslint

    # Optional modern runtime
    bun
  ];
}