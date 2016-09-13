class Yalwee::InstructionProvider
  Instruction = Yalwee::Instruction

  class OpcodeSeq
    def initialize start
      @current = start
    end

    def next
      value = @current 
      @current += 1
      return value
    end
  end

  def initialize
    @opcode_seq = OpcodeSeq.new 1

    @signatures = {
      add:  {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
      sub:  {dst: ['r'], src: ['r', 'const', 'int', 'uint']},

      smul: {dst: ['r'], src: ['r', 'const', 'int']},
      sdiv: {dst: ['r'], src: ['r', 'const', 'int']},
      
      bitor:  {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
      bitand: {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
      
      neg: {arg: ['r']},
      abs: {arg: ['r']},
      
      set: {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
      swap: {a: ['r'], b: ['r']},
      
      test_eq:  {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      test_neq: {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      test_lt:  {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      test_gt:  {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      test_lte: {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      test_gte: {a: ['r'], b: ['r', 'const', 'int', 'uint']},
      
      jump_rel:    {rel_offset: ['int']},
      jump_rel_if: {rel_offset: ['int']},
      jump_abs:    {abs_offset: ['uint']},
      jump_abs_if: {abs_offset: ['uint']},

      for_nz_init: {init: ['r'], step: ['int']},
      end_for_nz: {}
    }
  end

  def include? name
    return @signatures.include? name
  end

  def create_instructions name, args
    signature = @signatures[name]

    unless signature
      Yalwee.die "`#{name}': undefined symbol/instruction"
    end
    unless signature.length == args.length
      Yalwee.die "`#{name}': expected #{signature.length} args, got #{args.length}"
    end

    if args.length == 0
      return Instruction.new name, signature, [], @opcode_seq.next 
    end

    signature.each_with_index do |(param_name, whitelist), i|
      args[i].each do |arg|
        unless whitelist.include? arg.type 
          msg = "type error; expected #{whitelist.inspect}"
          Yalwee.die "`#{name}': #{msg}, got `#{arg.type}'"
        end
      end
    end

    return args.reduce(&:product).map {|args|
      Instruction.new name, signature, [*args], @opcode_seq.next 
    }
  end
end
