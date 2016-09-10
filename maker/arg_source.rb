module ArgSource
  class ValueParser
    def self.parse_range_or_array values
      return case values
        when Array then values.flatten
        when Range then values.to_a
        else raise "only Range, Array and Fixnum variadic args allowed"
      end
    end

    def self.parse_list values
      unless values.all? {|x| x.is_a? Fixnum}
        raise "only Fixnums is allowed inside variadic args"
      end
      return values
    end

    def self.parse values
      if values.length == 1
        if values[0].is_a? Fixnum
          return values
        else 
          return self.parse_range_or_array values[0]
        end
      else
        return self.parse_list values
      end
    end
  end

  def r *values
    values = ValueParser.parse values
    unless values.all? {|x| (0..8).include? x}
      raise "only 0..8 registers are available"
    end

    return (Arg.new 'r', values)
  end

  def imm *values
    values = ValueParser.parse values
    unless values.all? {|x| [8, 16, 32, 64].include? x}
      raise "only 8, 16, 32 and 64 bit immediates supported" 
    end

    return (Arg.new 'imm', values)
  end
  
  def const *values
    values = ValueParser.parse values
    unless values.all? {|x| x.is_a? Fixnum}
      raise "only Fixnum consts are allowed"
    end

    return (Arg.new 'const', values)
  end
end