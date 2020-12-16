# input = <<~INPUT
#   class: 0-1 or 4-19
#   row: 0-5 or 8-19
#   seat: 0-13 or 16-19

#   your ticket:
#   11,12,13

#   nearby tickets:
#   3,9,18
#   15,1,5
#   5,14,9
# INPUT

input = File.read('16.txt')

def main(input)
  parse(input)
  map_your_ticket(process_nearby_tickets).select { |_, name| name.start_with?('departure') }
                                         .map(&:first)
                                         .reduce(&:*)
end

def process_nearby_tickets
  ranges = @valid_ranges.values.flatten
  valid_nearby =
    @ticket_values['nearby'].select { |values| within_any_range?(values, ranges) }
  Hash[valid_nearby.transpose.each_with_index.to_a.map(&:reverse)]
end

def only_one_matching(values)
  matches = @valid_ranges.select { |_, ranges| within_any_range?(values, ranges) }
  matches.first.first if matches.size == 1
end

def within_any_range?(values, ranges)
  values.all? { |n| ranges.any? { |r| r.include?(n) } }
end

def parse(input) # rubocop:todo Metrics/MethodLength
  @valid_ranges = {}
  @ticket_values = Hash.new([])
  key = nil

  input.lines.each do |line|
    case line
    when /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/
      @valid_ranges[$1] = [$2.to_i..$3.to_i, $4.to_i..$5.to_i]
    when /(your|nearby) tickets?:/
      key = $1
    when /^[\d,]+$/
      @ticket_values[key] += [$&.chomp.split(/,/).map(&:to_i)]
    end
  end
end

def map_your_ticket(nearby_tickets_by_position)
  field_names = {}
  while nearby_tickets_by_position.any?
    nearby_tickets_by_position = nearby_tickets_by_position.reject do |position, values|
      name = only_one_matching(values) or next

      @valid_ranges.delete(name)
      field_names[position] = name
    end
  end

  @ticket_values['your'].first.each_with_index.map { |values, ix| [values, field_names[ix]] }
end

answer = main(input)
debug answer == 6_766_503_490_793
