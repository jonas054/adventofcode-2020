# input = <<~INPUT
#   1721
#   979
#   366
#   299
#   675
#   1456
# INPUT

p IO.read('1.txt').split.map(&:to_i).combination(2).find { |c| c.sum == 2020 }.reduce(&:*)

# 270144
