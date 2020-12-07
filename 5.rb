input = File.read('5.txt')

def seat(code)
  row = to_number(code, 0..6, 'FB')
  col = to_number(code, 7..9, 'LR')
  8 * row + col
end

def to_number(code, range, digits)
  code[range].tr(digits, '01').to_i(2)
end

raise unless seat('FBFBBFFRLR') == 357
raise unless seat('BFFFBBFRRR') == 567
raise unless seat('FFFBBBFRRR') == 119
raise unless seat('BBFFBBFRLL') == 820

lines = input.lines.map(&:chomp)
debug(lines.map { |line| seat(line) }.max) # 996
debug(lines.map { |line| seat(line) }.sort.each_cons(2).select { |a, b| b - a == 2 }) # 671
