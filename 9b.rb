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

step_1_nr = numbers[first_fail]

(0...numbers.size).each do |start_ix|
  found_size = (2..(numbers.size - start_ix)).find do |size|
    numbers[start_ix, size].sum == step_1_nr
  end
  next unless found_size

  range = numbers[start_ix, found_size].sort
  debug range.first + range.last
  break
end
