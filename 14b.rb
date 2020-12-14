# input = <<~INPUT
#   mask = 000000000000000000000000000000X1001X
#   mem[42] = 100
#   mask = 00000000000000000000000000000000X0XX
#   mem[26] = 1
# INPUT

input = File.read('14.txt')

def write_with_mask(address, value)
  @mask.chars.each_with_index { |char, ix| address[ix] = char if %w[1 X].include?(char) }
  nr_of_x = @mask.count('X')
  (0...(2**nr_of_x)).each do |floating_value|
    bit = nr_of_x
    @memory[address.gsub(/X/) { (floating_value >> (bit -= 1)) & 1 }] = value
  end
end

@memory = {}

input.lines.each do |line|
  case line
  when /mask = (.*)/ then @mask = $1
  when /mem\[(\d+)\] = (\d+)/ then write_with_mask(format('%036b', $1.to_i), $2.to_i)
  end
end

debug @memory.values.sum # 2900994392308
