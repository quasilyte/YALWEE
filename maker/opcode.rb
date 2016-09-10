class Opcode
  def initialize name, args
    @name, @args = name.to_s, args

    if @args.length == 0
      @label = @name
      @generator = @name
    else
      @label = "#{@name}_" + @args.map {|x| "#{x.name}#{x.value}"}.join('_')
      @generator = "#{@name}_" + @args.map {|x| "#{x.name}?"}.join('_') 
    end
  end

  attr_reader :name, :args, :label, :generator
end

