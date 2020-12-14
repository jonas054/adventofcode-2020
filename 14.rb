# input = <<~INPUT
#   mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
#   mem[8] = 11
#   mem[7] = 101
#   mem[8] = 0
# INPUT

input = File.read('14.txt')

def with_mask(value)
  ones = @mask.tr('X', '0').to_i(2)
  zeroes = @mask.tr('X', '1').to_i(2)
  value & zeroes | ones
end

memory = {}

input.lines.each do |line|
  case line
  when /mask = (.*)/ then @mask = $1
  when /mem\[(\d+)\] = (\d+)/ then memory[$1.to_i] = with_mask($2.to_i)
  end
end

debug memory.values.sum # 3059488894985
