class Yalwee::Instruction
  def initialize name, signature, args, opcode
    @name = name
    @signature = signature
    @args = args
    @opcode = opcode
  end

  attr_reader :name, :signature, :args, :opcode
end