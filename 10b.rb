# input = <<~INPUT
#   16
#   10
#   15
#   5
#   1
#   11
#   7
#   19
#   6
#   12
#   4
# INPUT

input = <<~INPUT
  28
  33
  18
  42
  31
  14
  46
  20
  48
  47
  24
  23
  49
  45
  19
  38
  39
  11
  1
  32
  25
  35
  8
  17
  7
  9
  4
  2
  34
  10
  3
INPUT

# input = File.read('10.txt')

def any_large_gap?(series)
  series.each_cons(2).find { |a, b| b - a > 3 }
end

adapters = input.lines.map(&:to_i)
adapters << 0
adapters << (adapters.max + 3)
adapters.sort!

count = 0
skippable = adapters.each_cons(3).map { |a, b, c| [b, c - a <= 3] }.select(&:last).map(&:first)

p skippable
p adapters - skippable
(0..skippable.size).each do |n|
  skippable.combination(n).each do |combo|
    arrangement = adapters - combo
    next if any_large_gap?(arrangement)

    count += 1
    puts "#{count} (#{100 * n / skippable.size}%)"
  end
end
