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

def count_all_yes(group)
  group.split("\n").map(&:chars).reduce(:&).map(&:size)
end

debug input.split("\n\n").map { |group| count_all_yes(group) }.map(&:sum).sum

# 3290
