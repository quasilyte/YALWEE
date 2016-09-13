# $LOAD_PATH << ENV['YALWEE_TOOLS']

module Yalwee
end

require_relative '../tools/assert.rb'
require_relative '../tools/die.rb'
require_relative '../tools/spec/arg.rb'
require_relative '../tools/spec/arg_provider.rb'
require_relative '../tools/spec/instruction.rb'
require_relative '../tools/spec/instruction_provider.rb'
require_relative '../tools/spec/spec.rb'
require_relative '../tools/asm/method.rb'
require_relative '../tools/asm/numerics.rb'
require_relative '../tools/asm/asm_template.rb'
require_relative '../tools/asm/asm_builder.rb'
require_relative '../tools/ee/evaluator_builder.rb'

spec = Yalwee::Spec.create {
  name 'gpaso'
  author 'quasilyte'
  version '0.1'

  description <<-INFO
    General purpose evaluator with 
    accumulator based arithmetic instruction set.
    No support for unsigned values.
  INFO

  # notation definition
  INT = int(8, 32, 64) # int sizes
  ACC = r(0)           # accumulator
  CX  = r(8)           # counter
  GPR = r(0..7)        # GP registers
  SR  = r(0, 8)        # registers with special purposes
  R   = r(0..8)        # any register

  instructions(
    (add R, const(1)),
    (add SR, const(4, 8)),
    (add SR, GPR),
    (add R, INT),

    # (sub SR, GPR),
    # (sub R, const(1)),
    # (sub SR, const(4, 8)),
    # (sub R, INT),

    # (smul ACC, GPR),
    # (smul GPR, INT),

    # (sdiv ACC, GPR),
    # (sdiv GPR, INT),

    # (bitor ACC, GPR),
    # (bitor GPR, INT),

    # (bitand ACC, GPR),
    # (bitand GPR, INT),

    # (abs GPR),
    # (neg GPR),

    # (set R, const(0)),
    (set R, INT),

    # (swap ACC, r(1..7)),

    # (test_eq ACC, r(1..7)),
    # (test_eq GPR, const(0)),

    # (test_neq ACC, r(1..7)),
    # (test_neq GPR, const(0)),

    # (test_lt ACC, r(1..7)),
    # (test_lte ACC, r(1..7)),

    # (test_gt ACC, r(1..7)),
    # (test_gte ACC, r(1..7)),

    # (jump_rel int(32)),
    # (jump_rel_if int(32)),

    # (jump_abs uint(32)),
    # (jump_abs_if uint(32)),

    (for_nz_init r(0), int(8)),
    (end_for_nz)
  )
}

IO.write('data/assembler.rb', (Yalwee::AsmBuilder.new spec).build) 
(Yalwee::EvaluatorBuilder.new spec).run './output/gpa'

