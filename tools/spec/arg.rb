class Yalwee::Arg
  def initialize type, value
    @type, @value = type, value
  end

  def imm?
    return @type == 'imm' 
  end

  def r?
    return @type == 'r' 
  end

  def const?
    return @type == 'const'
  end

  def sym
    return (@type + @value.to_s).to_sym
  end

  attr_reader :name, :type, :value
end