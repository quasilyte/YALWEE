class CodeGenerator
  def initialize
    @output_path = ''
    @options = []
    @opcodes = {}
  end

  attr_writer :output_path, :opcodes, :options

  def run
    labels, generators = [], []

    n = 1
    @opcodes.each {|name, ops|
      generators << "%include '/opcodes/#{name}.s'"
      ops.each {|op|
        labels << "@label #{op.label} ;; #{n}"
        generators << "@#{op.generator} " + (op.args.map(&:value).join ',')
        n += 1
      }
    }

    IO.write("#{@output_path}/eval.s", (IO.read "src/core/eval.s"))
    IO.write("#{@output_path}/op_labels.s", (labels.join "\n"))
    IO.write("#{@output_path}/op_generators.s", (generators.join "\n") )
  end
end