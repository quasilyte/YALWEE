module Yalwee::Numerics
  @@little_endian = true #FIXME

  class Check
    def self.overflow value, min, max, name
      if value < min || value > max
        Yalwee::die "#{value} overflows #{name}"
      end
    end
  end

  def bit_string pack
    return pack.bytes.map {|byte| '%08b' % byte}.join
  end

  def f64_bits value
    fmt = @@little_endian ? 'E' : 'G'
    return [value].pack(fmt).bytes.map {|byte| '%08b' % byte}.join
  end

  def uint8_bits value
    return bit_string [value].pack('C')
  end

  def uint16_bits value
    return bit_string [value].pack('S')
  end

  def int8_bits value
    return bit_string [value].pack('c')
  end

  def int16_bits value
    return bit_string [value].pack('s')
  end

  def int32_bits value
    return bit_string [value].pack('l')
  end

  def int64_bits value
    return bit_string [value].pack('q')
  end

  def f64 value
    return [f64, (f64_bits value)]
  end

  def uint8 value 
    Check.overflow value, 0, 255, 'uint8'
    return [:uint8, (uint8_bits value)]
  end

  def uint16 value
    Check.overflow value, 0, 65535, 'uint16'
    return [:uint16, (uint16_bits value)]
  end

  def int8 value
    Check.overflow value, -128, 127, 'int8'
    return [:int8, (int8_bits value)]
  end

  def int16 value
    Check.overflow value, -32768, 32767, 'int16'
    return [:int16, (int16_bits value)]
  end

  def int32 value
    Check.overflow value, –2147483648, 2147483647, 'int32'
    return [:int32, (int32_bits value)]
  end

  def int64 value
    return [:int64, (int64_bits value)]
  end
end