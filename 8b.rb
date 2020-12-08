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
    case instruction
    when 'acc' then acc += argument
    when 'jmp' then pc += argument - 1
    end
    pc += 1
    return [:normal_exit, acc] if pc == program.size
    return [:infinite_loop, acc] if executed_lines.include?(pc)
  end
end

def parse(line)
  raise line unless line =~ /([a-z]{3}) ([+-]\d+)/

  [$1, $2.to_i]
end

def replace_instruction(program, index, replacement)
  current = program[index][0]
  program[index][0] = replacement
  result = yield
  program[index][0] = current
  result
end

OPERATORS = %w[jmp nop].freeze

program = input.lines.map { |line| parse(line) }
program.each_index do |ix|
  instruction = program[ix][0]
  next unless OPERATORS.include?(instruction)

  replacement = OPERATORS[1 - OPERATORS.index(instruction)]
  program[ix][0] = replacement
  result = run(program)
  debug result
  exit if result.first == :normal_exit
  program[ix][0] = instruction
end
