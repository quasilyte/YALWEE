require 'erb'
require 'pp'

class AsmTemplate
  def initialize mnemonics, opcodes
    @template = ERB.new(IO.read('tools/asm/assembler.erb'))
    @mnemonics = mnemonics
    @opcodes = opcodes
  end

  def render
    return @template.result(binding)
  end
end