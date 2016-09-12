class Yalwee::Spec
  include Yalwee::ArgProvider

  def initialize
    @name = 'unnamed_evaluator'    
    @author_name = 'unknown author'
    @description = 'yet another YALWEE spec'
    @version = '0.0.1'
    @instruction_map = Hash.new {|hash, key| hash[key] = [] }
    @instruction_list = []

    @instruction_provider = Yalwee::InstructionProvider.new 
  end

  attr_reader :name, :author_name, :description, :version,
              :instruction_map, :instruction_list

  def method_missing name, *args
    if @instruction_provider.include? name
      return @instruction_provider.create_instructions name, args
    end

    raise NameError, "undefined local variable or method `#{name}' for #{self.class}"
  end

  def self.create &block
    spec = new 
    spec.instance_eval &block    
    return spec
  end

private

  def name name
    @name = name
  end

  def author name
    @author_name = name
  end

  def description description
    @description = description
  end

  def version version
    @version = version
  end

  def instructions *instructions
    instructions.flatten.each {|instruction|
      @instruction_map[instruction.name] << instruction
      @instruction_list << instruction
    }
  end
end