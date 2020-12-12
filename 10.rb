# input = <<~INPUT
#   28
#   33
#   18
#   42
#   31
#   14
#   46
#   20
#   48
#   47
#   24
#   23
#   49
#   45
#   19
#   38
#   39
#   11
#   1
#   32
#   25
#   35
#   8
#   17
#   7
#   9
#   4
#   2
#   34
#   10
#   3
# INPUT

input = File.read('10.txt')

diffs = (input.lines.map(&:to_i) << 0).sort.each_cons(2).map { |a, b| b - a }.group_by(&:to_i)
p diffs[1].size, diffs[3].size + 1
debug diffs[1].size * (diffs[3].size + 1)
