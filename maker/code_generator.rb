class CodeGenerator
  def initialize
    @output_path = ''
    @evaluator_options = []
    @evaluator_opcodes = []
    @template = IO.read "src/core/eval.s"
  end

  attr_writer :output_path, :evaluator_options, :evaluator_opcodes  

  def run
    op_labels, op_generators = [], []

    @evaluator_opcodes.each do |opcode_name, opcode_args|
      op_generators << "%include '/opcodes/#{opcode_name}.s'"

      opcode_args.each {|opcode_arg|
        opcode_labels, opcode_generators = (opcode_parts opcode_name, opcode_arg)
        op_labels << opcode_labels
        op_generators << opcode_generators
      }
    end

    @template.sub! ';[[op_labels]];', (op_labels.join "\n")
    @template.sub! ';[[op_generators]];', (op_generators.join "\n") 

    IO.write(@output_path, @template)
  end

  private def opcode_parts name, args
    if args.length == 0
      return [
        args.map {|arg| "@label #{name}"},
        args.map {|arg| "@#{name}"}
      ]
    end

    op_labels = args.map {|arg|
      arg.values.map {|value| "#{arg.name}#{value}"}
    }.reduce {|prev, curr|
      prev.map {|x| curr.map {|y| "#{x}_#{y}"}}.flatten
    }.map {|arg_string|
      "@label #{name}_#{arg_string}"
    }

    op_generator_name = "@#{name}_" + args.map {|x| "#{x.name}?"}.join('_') 
    op_generators = args.map {|arg| arg.values}.reduce {|prev, curr|
      prev.map {|x| curr.map {|y| "#{x}, #{y}"}}.flatten
    }.map {|arg_string| "#{op_generator_name} #{arg_string}"}

    return [op_labels, op_generators]
  end 
end