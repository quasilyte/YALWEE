def blame op_prefix, arg, domains
  raise "#{op_prefix} should belong to #{domains.inspect}; \"#{arg.name}\" given"
end

def assert what, arg, domains, op_name = caller[0]
  unless domains.include? arg.name
    blame "#{op_name}: #{what}", arg, domains
  end
end