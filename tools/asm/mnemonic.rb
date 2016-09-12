class Mnemonic
  def initialize name, params, opcode = -1
    @name = name
    @params = params
    @opcode = opcode
  end

  attr_reader :name, :params, :opcode
end