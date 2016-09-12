module Yalwee::InstructionProvider
  @@signatures = {
    add:  {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
    sub:  {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
    smul: {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
    sdiv: {dst: ['r'], src: ['r', 'const', 'int', 'uint']},
    
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
    jump_abs_if: {abs_offset: ['uint']}
  }

  def self.lookup name  
    return @@signatures[name]
  end

  def method_missing name, *args
    signature = @@signatures

    unless signature
      raise "`#{name}': undefined symbol/instruction"
    end
    unless signature.length == args.length
      raise "`#{name}': expected #{signature.length} args, got #{args.length}"
    end
    signature.each_with_index do |(param_name, whitelist), i|
      args[i].each do |arg|
        unless whitelist.include? arg.name 
          msg = "type error; expected #{whitelist.inspect}"
          raise "`#{name}': `#{arg.name}': #{msg}"
        end
      end
    end
  end
end
