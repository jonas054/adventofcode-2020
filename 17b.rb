require '17'

# input = <<~INPUT
#   .#.
#   ..#
#   ###
# INPUT

input = <<~INPUT
  .......#
  ....#...
  ...###.#
  #...###.
  ....##..
  ##.#..#.
  ###.#.#.
  ....#...
INPUT

DIRECTIONS = [-1, 0, 1].repeated_permutation(4).to_a - [[0, 0, 0, 0]]

cube = {}
input.lines.map(&:chomp).each_with_index do |line, y|
  line.chars.each_with_index { |char, x| cube[[x, y, 0, 0]] = char }
end
6.times { cube = cycle(DIRECTIONS, cube) }
debug cube.values.count('#') # 1620
