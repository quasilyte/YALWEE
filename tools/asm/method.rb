class Yalwee::AsmMethod
  def initialize name, params, opcode
    @name = name
    @params = params
    @opcode = opcode
  end

  attr_reader :name, :params, :opcode
end