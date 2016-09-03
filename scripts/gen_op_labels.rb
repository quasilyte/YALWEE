$range_rx = /\[(\d)-(\d)\]/
$list_rx = /\((.*?)\)/

def parse_list tmpl
  list = tmpl.match $list_rx

  if list
    return list[1].split(';').map {|elem| parse_list tmpl.sub($list_rx, elem)}
  else
    return tmpl
  end
end

def parse_range tmpl
  range = tmpl.match $range_rx
 
  if range
    low, high = range[1].to_i, range[2].to_i
    return (low..high).map {|i| parse_range tmpl.sub($range_rx, i.to_s)}
  else
    return tmpl
  end
end

IO.readlines('oplist.txt')
  .map(&method(:parse_list))
  .flatten
  .reject {|line| line.empty? || line == "\n"}
  .flat_map(&method(:parse_range))
  .each(&method(:puts))
