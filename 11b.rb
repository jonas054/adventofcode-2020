# input = <<~INPUT
#   L.LL.LL.LL
#   LLLLLLL.LL
#   L.L.L..L..
#   LLLL.LL.LL
#   L.LL.LL.LL
#   L.LLLLL.LL
#   ..L.L.....
#   LLLLLLLLLL
#   L.LLLLLL.L
#   L.LLLLL.LL
# INPUT

input = File.read('11.txt')

DIRECTIONS = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]

def apply_rules(rows)
  result = rows.map(&:dup)
  rows.each_with_index do |row, row_ix|
    row.chars.each_with_index do |seat, col_ix|
      occupied_count = DIRECTIONS.count { |dx, dy| occupied?(rows, row_ix, dy, col_ix, dx) }
      if seat == 'L' && occupied_count == 0
        result[row_ix][col_ix] = '#'
      elsif seat == '#' && occupied_count >= 5
        result[row_ix][col_ix] = 'L'
      end
    end
  end
  result
end

def occupied?(rows, y, dy, x, dx)
  loop do
    x += dx
    y += dy
    return false unless (0...rows.size).include?(y) && (0...rows[y].size).include?(x)
    return false if rows[y][x] == 'L'
    return true if rows[y][x] == '#'
  end
end

current_state = input.lines
loop do
  next_state = apply_rules(current_state)
  break if next_state == current_state

  current_state = next_state
  info current_state.join
end

debug current_state.join.count('#')
