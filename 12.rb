# input = <<~INPUT
#   F10
#   N3
#   F7
#   R90
#   F11
# INPUT

input = File.read('12.txt')

DIRECTIONS = { 'N' => 0 - 1i, 'S' => 0 + 1i, 'E' => 1, 'W' => -1 }
ANGLES = { 0 => 'E', 90 => 'N', 180 => 'W', 270 => 'S' }
TURNS = { 'L' => 1, 'R' => -1 }

facing = 0
pos = 0

input.lines.each do |line|
  raise unless line =~ /^([NESWLRF])(\d+)$/

  action, value = $1, $2.to_i

  case action
  when 'N', 'S', 'E', 'W' then pos += DIRECTIONS[action] * value
  when 'L', 'R' then facing = (facing + TURNS[action] * value) % 360
  when 'F' then pos += DIRECTIONS[ANGLES[facing]] * value
  end
  info "After #{line.chomp}: at #{pos} facing #{ANGLES[facing]}"
end

debug pos.real.abs + pos.imag.abs
