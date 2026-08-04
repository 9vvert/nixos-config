{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      # ARM 32-bit Linux, hard-float
      pkgsCross.armv7l-hf-multiplatform.stdenv.cc

      # ARM 64-bit Linux
      pkgsCross.aarch64-multiplatform.stdenv.cc

      # RISC-V 32-bit Linux
      pkgsCross.riscv32.stdenv.cc

      # RISC-V 64-bit Linux
      pkgsCross.riscv64.stdenv.cc
    ];
  };

}
