# input = <<~INPUT
#   nop +0
#   acc +1
#   jmp +4
#   acc +3
#   jmp -3
#   acc -99
#   acc +1
#   jmp -4
#   acc +6
# INPUT

input = File.read('8.txt')

program = input.lines.map(&:chomp)
pc = 0
acc = 0
executed_lines = []
loop do
  raise "Address #{pc} out of bounds" unless (0...program.size).include?(pc)

  line = program[pc]
  raise line unless line =~ /([a-z]{3}) ([+-]\d+)/

  executed_lines << pc
  instruction, argument = $1, $2.to_i
  case instruction
  when 'acc' then acc += argument
  when 'jmp' then pc += argument - 1
  end
  puts "#{Rainbow(line).cyan} #{Rainbow(acc).yellow}"
  pc += 1
  break if executed_lines.include?(pc)
end
