# input = <<~INPUT
#   1721
#   979
#   366
#   299
#   675
#   1456
# INPUT

input = File.read('1.txt')
debug input.split.map(&:to_i).combination(3).find { |combo| combo.sum == 2020 }.reduce(&:*)

# 513 + 512 + 995 = 2020
# 513 * 512 * 995 = 261342720
