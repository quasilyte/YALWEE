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

  def opcodes *opcode_packs
    opcode_packs.flatten.each {|opcode|
      if @@opcodes[opcode.name]
        @@opcodes[opcode.name] << opcode
      else
        @@opcodes[opcode.name] = [opcode]
      end
    }
  end

  at_exit do
    generator = CodeGenerator.new

    generator.output_path = "output/#{@@name}"
    generator.options = []
    generator.opcodes = @@opcodes
    generator.run
  end
end