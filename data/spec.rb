require_relative '../maker/include.rb'

extend AsmSpec

name 'gpa'
description 'general purpose, accumulator based machine'
author 'quasilyte'
version '0.1'

interfaces ['C']

# notation definition
$int = int(8, 32, 64) # immediate sizes
$acc = r(0)           # accumulator
$cx  = r(8)           # counter
$gpr = r(1..7)        # GP registers, except accumulator
$GPR = r(0..7)        # GP registers
$SR  = r(0, 8)        # registers with special purposes
$R   = r(0..8)        # any register

opcodes(
  (add $SR, $GPR),
  (add $R, const(1)),
  (add $SR, const(4, 8)),
  (add $R, $int),
  (add $R, uint(8))

  (sub $SR, $GPR),
  # (sub $R, const(1)),
  # (sub $SR, const(4, 8)),
  # (sub $R, $int),

  # (mul $acc, $GPR),
  # (mul $GPR, $int),

  # (div $acc, $GPR),
  # (div $GPR, $int),

  # (bitor $acc, $GPR),
  # (bitor $GPR, $int),

  # (bitand $acc, $GPR),
  # (bitand $GPR, $int),

  # (abs $GPR),
  # (neg $GPR),

  # (set $R, const(0)),
  # (set $R, $imm),
  # *(0..8).map {|x| (set r(x), $GPR - r(x))},

  # (swap $acc, $gpr),

  # (test_eq $acc, $gpr),
  # (test_eq $GPR, const(0)),

  # (test_neq $acc, $gpr),
  # (test_neq $GPR, const(0)),

  # (test_lt $acc, $gpr),
  # (test_lte $acc, $gpr),

  # (test_gt $acc, $gpr),
  # (test_gte $acc, $gpr),

  # (jump_rel imm(32)),
  # (jump_rel_if imm(32)),

  # (jump_abs imm(32)),
  # (jump_abs_if imm(32))
)
