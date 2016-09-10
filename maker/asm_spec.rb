module AsmSpec
  include OpcodeSource

  @@name = 'unnamed_asm_spec'
  @@author_name = 'unknown'
  @@description = 'yet another asm spec'
  @@version = '0.0.1'
  @@interfaces = []  
  @@opcodes = {}

  def name name
    @@name = name 
  end

  def author name
    @@author_name = name
  end

  def description description
    @@description = description
  end

  def version version
    @@version = version
  end

  def interfaces interfaces
    @@interfaces = interfaces
  end

  def opcodes *opcodes  
    opcodes.each {|opcode| @@opcodes[opcode.name] = []}
    opcodes.each {|opcode|
      @@opcodes[opcode.name] << opcode.args
    }
  end

  at_exit do
    generator = CodeGenerator.new

    generator.output_path = "output/#{@@name}.s"
    generator.evaluator_options = []
    generator.evaluator_opcodes = @@opcodes
    generator.run

    # puts @@opcodes.inspect
    # puts 'generating spec...'
  end
end