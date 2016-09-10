class Opcode
  def initialize name, args
    @name, @args = name, args
  end

  attr_reader :name, :args
end