class Arg
  def initialize name, values
    @name, @values = name, values
  end

  def -(arg)
    unless @name == arg.name
      raise 'can only substract args within same domain'
    end

    return (Arg.new @name, @values - arg.values)
  end

  attr_reader :name, :values
end