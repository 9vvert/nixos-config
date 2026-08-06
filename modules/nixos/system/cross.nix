{ pkgs, inputs, ... }:
let
  aarch64_cross = pkgs.pkgsCross.aarch64-multiplatform;
  aarch64_prefix = aarch64_cross.stdenv.cc.targetPrefix;

  aarch32_cross = pkgs.pkgsCross.armv7l-hf-multiplatform;
  aarch32_prefix = aarch32_cross.stdenv.cc.targetPrefix;

  riscv64_cross = pkgs.pkgsCross.riscv64;
  riscv64_prefix = riscv64_cross.stdenv.cc.targetPrefix;

  riscv32_cross = pkgs.pkgsCross.riscv32;
  riscv32_prefix = riscv32_cross.stdenv.cc.targetPrefix;
in
{
  environment = {
    systemPackages = [
      # ARM 64-bit Linux
      aarch64_cross.stdenv.cc
      # ARM 32-bit Linux, hard-float
      aarch32_cross.stdenv.cc
      # RISC-V 64-bit Linux
      riscv64_cross.stdenv.cc
      # RISC-V 32-bit Linux
      riscv32_cross.stdenv.cc
    ];

    sessionVariables = {
      AARCH64_BIN = "${aarch64_cross.stdenv.cc}/bin";
      AARCH64_LIBC = "${aarch64_cross.stdenv.cc.libc}";
      AARCH64_INTERP = "${aarch64_cross.stdenv.cc.libc}/lib/ld-linux-aarch64.so.1";
      AARCH64_GCC_LIB = "${aarch64_cross.stdenv.cc.cc.lib}";

      AARCH32_BIN = "${aarch32_cross.stdenv.cc}/bin";
      AARCH32_LIBC = "${aarch32_cross.stdenv.cc.libc}";
      AARCH32_INTERP = "${aarch32_cross.stdenv.cc.libc}/lib/ld-linux-armhf.so.3";
      AARCH32_GCC_LIB = "${aarch32_cross.stdenv.cc.cc.lib}";

      RISCV64_BIN = "${riscv64_cross.stdenv.cc}/bin";
      RISCV64_LIBC = "${riscv64_cross.stdenv.cc.libc}";
      RISCV64_INTERP = "${riscv64_cross.stdenv.cc.libc}/lib/ld-linux-riscv64-lp64d.so.1";
      RISCV64_GCC_LIB = "${riscv64_cross.stdenv.cc.cc.lib}";

      RISCV32_BIN = "${riscv32_cross.stdenv.cc}/bin";
      RISCV32_LIBC = "${riscv32_cross.stdenv.cc.libc}";
      RISCV32_INTERP = "${riscv32_cross.stdenv.cc.libc}/lib/ld-linux-riscv32-ilp32d.so.1";
      RISCV32_GCC_LIB = "${riscv32_cross.stdenv.cc.cc.lib}";
    };
  };

}
