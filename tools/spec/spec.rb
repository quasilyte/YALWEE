class Yalwee::Spec
  def initialize
    @name = 'unnamed_evaluator'    
    @author_name = 'unknown author'
    @description = 'yet another YALWEE spec'
    @version = '0.0.1'
    @instructions = Hash.new {|hash, key| hash[key] = [] }
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
      @instructions[instruction.name] << instruction
    }
  end
end