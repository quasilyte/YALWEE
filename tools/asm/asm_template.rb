require 'erb'
require 'pp'

class Yalwee::AsmTemplate
  include Yalwee::Numerics

  @@template = ERB.new(IO.read('tools/asm/asm.erb'), nil, '-')

  def initialize methods, dispatch_table
    @methods = methods  
    @dispatch_table = dispatch_table
  end

  def render
    return @@template.result(binding)
  end
end