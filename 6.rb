# input = <<~INPUT
#   abc

#   a
#   b
#   c

#   ab
#   ac

#   a
#   a
#   a
#   a

#   b
# INPUT

input = File.read('6.txt')

debug input.split("\n\n").map { |group| group.gsub(/\s/, '').chars.uniq.size }.sum
