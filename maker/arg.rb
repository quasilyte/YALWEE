class Arg
  def initialize name, value
    @name, @value = name, value
  end

  def imm?
    return @name == 'imm' 
  end

  def r?
    return @name == 'r' 
  end

  def const?
    return @name == 'const'
  end

  attr_reader :name, :value
end