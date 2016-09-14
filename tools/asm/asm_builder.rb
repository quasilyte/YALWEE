class Yalwee::AsmBuilder
  AsmMethod = Yalwee::AsmMethod

  def initialize spec
    @options = [] #FIXME

    (methods, dispatch_table) = template_data spec.instruction_map
    @template = Yalwee::AsmTemplate.new methods, dispatch_table
  end

  attr_writer :options 

  def build
    return @template.render
  end

  private def template_data instruction_map
    methods, table = [], {}

    instruction_map.each do |name, instructions|
      # any instruction will do
      instruction = instructions[0]

      if instruction.args.length != 0 
        table[name] = instructions.
          map {|x| dispatcher_entry x}.
          reduce {|x, y| x.merge(y) {|_, a, b| a.merge b}}
      end

      params = instruction.signature.keys
      name = instruction.name 
      opcode = instruction.opcode
      methods << (AsmMethod.new name, params, opcode)
    end

    return [methods, table]
  end 

  private def dispatcher_entry instruction
    args = instruction.args
    opcode = instruction.opcode

    return case args.length
    when 1 then {args[0].sym => opcode}
      when 2 then {args[0].sym => {args[1].sym => opcode}}
      when 3 then {args[0].sym => {args[1].sym => {args[2].sym => opcode}}}
      else Yalwee::die "arity is too high (3 is max)"
    end
  end
end