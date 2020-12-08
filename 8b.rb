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

def run(program) # rubocop:todo Metrics/MethodLength
  pc = acc = 0
  executed_lines = []
  loop do
    raise "Address #{pc} out of bounds" unless (0...program.size).include?(pc)

    executed_lines << pc
    instruction, argument = program[pc]
    acc += argument if instruction == 'acc'
    pc += argument - 1 if instruction == 'jmp'
    pc += 1
    return acc if pc == program.size
    return nil if executed_lines.include?(pc)
  end
end

def parse(line)
  raise line unless line =~ /([a-z]{3}) ([+-]\d+)/

  [$1, $2.to_i]
end

OPERATORS = %w[jmp nop].freeze

program = input.lines.map { |line| parse(line) }
program.each_with_index do |(instruction, _), ix|
  next unless OPERATORS.include?(instruction)

  replacement = OPERATORS[1 - OPERATORS.index(instruction)]
  program[ix][0] = replacement
  @result = run(program) and break
  program[ix][0] = instruction
end
debug @result
