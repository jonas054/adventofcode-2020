# input = <<~INPUT
#   ..##.......
#   #...#...#..
#   .#....#..#.
#   ..#.#...#.#
#   .#...##..#.
#   ..#.##.....
#   .#.#.#....#
#   .#........#
#   #.##...#...
#   #...##....#
#   .#..#...#.#
# INPUT

input = File.read('3.txt')

def count_trees(lines, steps_right, steps_down)
  trees_hit = 0
  row = 0
  col = 0
  while row < lines.length
    line = lines[row]
    trees_hit += 1 if line[col % line.chomp.length] == '#' && col > 0
    row += steps_down
    col += steps_right
  end
  trees_hit
end

debug count_trees(input.lines, 3, 1)

# 203
