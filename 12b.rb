# input = <<~INPUT
#   F10
#   N3
#   F7
#   R90
#   F11
# INPUT

input = File.read('12.txt')

DIRECTIONS = { 'N' => 0 - 1i, 'S' => 0 + 1i, 'E' => 1, 'W' => -1 }
TURNS = { 'L' => 1, 'R' => -1 }

def turn(wp, degrees)
  (degrees % 360 / 90).times { wp = Complex(wp.imag, -wp.real) }
  wp
end

waypoint = 10 - 1i
pos = 0

input.lines.each do |line|
  raise unless line =~ /^([NESWLRF])(\d+)$/

  action, value = $1, $2.to_i

  case action
  when 'N', 'S', 'E', 'W' then waypoint += DIRECTIONS[action] * value
  when 'L', 'R' then waypoint = turn(waypoint, TURNS[action] * value)
  when 'F' then pos += waypoint * value
  end
  info "After #{line.chomp}: at #{pos} with waypoint #{waypoint}"
end

debug pos.real.abs + pos.imag.abs
