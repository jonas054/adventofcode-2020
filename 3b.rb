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

@input = File.read('3.txt')

def count_trees(steps)
  trees_hit = 0
  pos = 0
  while pos.imag < @input.lines.length
    line = @input.lines[pos.imag]
    trees_hit += 1 if line[pos.real % line.chomp.length] == '#'
    pos += steps
  end
  trees_hit
end

debug [1 + 1i, 3 + 1i, 5 + 1i, 7 + 1i, 1 + 2i].map { |steps| count_trees(steps) }.reduce(&:*)

# 3316272960
