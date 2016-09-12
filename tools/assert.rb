module Yalwee::Assert
  def self.type name, value, type
    unless value.is_a? type
      raise(
        TypeError,
        "`#{name}' type error: expected #{type}, got #{value.class}"
      )
    end
  end
end