module OpcodeSource
  include ArgSource

  @@source = {
    add: {dst: ['r'], src: ['r', 'const', 'imm']},
    sub: {dst: ['r'], src: ['r', 'const', 'imm']},
    mul: {dst: ['r'], src: ['r', 'const', 'imm']},
    div: {dst: ['r'], src: ['r', 'const', 'imm']},
    bitor: {dst: ['r'], src: ['r', 'const', 'imm']},
    bitand: {dst: ['r'], src: ['r', 'const', 'imm']},
    neg: {arg: ['r']},
    abs: {arg: ['r']},
    set: {dst: ['r'], src: ['r', 'const', 'imm']},
    swap: {a: ['r'], b: ['r']},
    test_eq: {a: ['r'], b: ['r', 'const', 'imm']},
    test_neq: {a: ['r'], b: ['r', 'const', 'imm']},
    test_lt: {a: ['r'], b: ['r', 'const', 'imm']},
    test_gt: {a: ['r'], b: ['r', 'const', 'imm']},
    test_lte: {a: ['r'], b: ['r', 'const', 'imm']},
    test_gte: {a: ['r'], b: ['r', 'const', 'imm']},
    jump_rel: {rel_offset: ['imm']},
    jump_rel_if: {rel_offset: ['imm']},
    jump_abs: {abs_offset: ['imm']},
    jump_abs_if: {abs_offset: ['imm']}
  }

  def method_missing name, *args    
    opcode = @@source[name]

    raise "undefined symbol/opcode: #{name}" unless opcode
    unless opcode.length == args.length
      raise "`#{name}': expected #{opcode.length} args, got #{args.length}"
    end

    opcode.each_with_index {|(param_name, domain), i|
      args[i].each {|arg| assert param_name, arg, domain, name}
    }

    return args.reduce(&:product).map {|args|
      Opcode.new name, args
    }
  end
end