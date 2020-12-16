# input = <<~INPUT
#   class: 1-3 or 5-7
#   row: 6-11 or 33-44
#   seat: 13-40 or 45-50

#   your ticket:
#   7,1,14

#   nearby tickets:
#   7,3,47
#   40,4,50
#   55,2,20
#   38,6,12
# INPUT

input = File.read('16.txt')

valid_ranges = {}
values = Hash.new([])
state = :normal

input.lines.each do |line|
  case line
  when /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/
    valid_ranges[$1] = [($2.to_i..$3.to_i), ($4.to_i..$5.to_i)]
  when /your ticket:/
    state = :your_ticket
  when /nearby tickets:/
    state = :nearby_tickets
  when /^[\d,]+$/
    values[state] += [$&.chomp.split(/,/).map(&:to_i)]
  when "\n"
    nil
  else
    raise line.inspect
  end
end

all_ranges = valid_ranges.values.flatten
pp values[:nearby_tickets].flatten.select { |n| all_ranges.none? { |range| range.include?(n) } }.sum
