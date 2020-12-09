# input = <<~INPUT
#   35
#   20
#   15
#   25
#   47
#   40
#   62
#   55
#   65
#   95
#   102
#   117
#   150
#   182
#   127
#   219
#   299
#   277
#   309
#   576
# INPUT

input = File.read('9.txt')

numbers = input.lines.map(&:to_i)
PREAMBLE = 25

first_fail = (PREAMBLE...numbers.length).find do |ix|
  !numbers[ix - PREAMBLE, PREAMBLE].combination(2).map(&:sum).index(numbers[ix])
end

debug numbers[first_fail]
