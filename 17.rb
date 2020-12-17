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

def cycle(directions, current)
  next_cube = current.dup
  current.each_key do |key|
    directions.each { |dir| next_cube[add(key, dir)] ||= '.' if current[key] == '#' }
  end
  next_cube.each do |key, value|
    count = count_active_around(directions, current, key)
    if value == '#'
      next_cube[key] = '.' unless (2..3).include?(count)
    elsif count == 3
      next_cube[key] = '#'
    end
  end
end

def count_active_around(directions, cube, key)
  directions.count { |dir| cube[add(key, dir)] == '#' }
end

def add(pos, dir)
  pos.zip(dir).map(&:sum)
end

# def display(cube)
#   all_x, all_y, all_z = cube.keys.transpose
#   (all_z.min..all_z.max).each do |z|
#     puts "z=#{z}"
#     (all_y.min..all_y.max).each do |y|
#       (all_x.min..all_x.max).each { |x| print cube[[x, y, z]] || '?' }
#       puts
#     end
#     puts
#   end
# end

if $PROGRAM_NAME == __FILE__
  directions = [-1, 0, 1].repeated_permutation(3).to_a - [[0, 0, 0]]

  cube = {}
  input.lines.map(&:chomp).each_with_index do |line, y|
    line.chars.each_with_index { |char, x| cube[[x, y, 0]] = char }
  end
  6.times { cube = cycle(directions, cube) }
  debug cube.values.count('#') # 232
end
