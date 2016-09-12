class Yalwee::EvaluatorBuilder
  def initialize spec
    unless ENV['YALWEE_HOME']
      Yalwee::die "YALWEE_HOME env var required"
    end

    @instruction_map = spec.instruction_map
  end

  def run output_path
    home_path = ENV['YALWEE_HOME']
    template_path = "#{home_path}/src/core/eval.s"
    deps_path = "#{home_path}/src/instructions"

    deps, labels, generators = [], [], []
    
    @instruction_map.each {|name, instructions|
      deps << "%include \'#{deps_path}/#{name}.s'"
      labels << ";;;; #{name}"
      generators << ";;;; #{name}"

      instructions.each {|instruction|
        if instruction.args.length == 0
          labels << "@label #{instruction.name} ;; #{instruction.opcode}"
          generators << "@? #{instruction.name}"
        else
          name = instruction.name
          args = instruction.args

          label = "#{name}_" + args.map {|x| "#{x.type}#{x.value}"}.join('_')
          labels << "@label #{label} ;; #{instruction.opcode}"

          generator = "?_" + args.map {|x| "#{x.type}?"}.join('_')
          values = (instruction.args.map(&:value).join ',')                  
          generators << "@#{generator} #{name}, #{values}" 
        end
      }
    }

    IO.write("#{output_path}/eval.s", (IO.read template_path))
    IO.write("#{output_path}/deps.s", (deps.join "\n"))
    IO.write("#{output_path}/instruction_labels.s", (labels.join "\n"))
    IO.write("#{output_path}/instruction_generators.s", (generators.join "\n") )
  end
end
