# input = <<~INPUT
#   939
#   7,13,x,x,59,x,31,19
# INPUT

input = File.read('13.txt')

departure_time = input.lines.first.to_i
buses = input.lines.last.split(/,/).reject { |id| id == 'x' }.map(&:to_i)

debug buses.map { |id| [id, id - departure_time % id] }.min_by(&:last).reduce(&:*)
