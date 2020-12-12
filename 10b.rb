# input = <<~INPUT
#   16
#   10
#   15
#   5
#   1
#   11
#   7
#   19
#   6
#   12
#   4
# INPUT

# input = <<~INPUT
#   28
#   33
#   18
#   42
#   31
#   14
#   46
#   20
#   48
#   47
#   24
#   23
#   49
#   45
#   19
#   38
#   39
#   11
#   1
#   32
#   25
#   35
#   8
#   17
#   7
#   9
#   4
#   2
#   34
#   10
#   3
# INPUT

input = File.read('10.txt')

def no_large_gaps?(combo)
  (@adapters - combo.map { |ix| @adapters[ix] }).each_cons(2).none? { |a, b| b - a > 3 }
end

def grouped(indexes) # rubocop:todo Metrics/MethodLength
  groups = []
  group = [indexes.first]
  indexes.each_cons(2) do |prev, ix|
    if ix == prev + 1
      group << ix
    else
      groups << group
      group = [ix]
    end
  end
  groups << group
end

def count_legal_combinations(skipped_indexes)
  (0..skipped_indexes.size).map { |size| skipped_indexes.combination(size).to_a }
                           .flatten(1)
                           .count { |combo| no_large_gaps?(combo) }
end

@adapters = [0] + input.lines.map(&:to_i).sort
@adapters << @adapters.last + 3

skippable_indexes =
  @adapters.each_index
           .each_cons(3)
           .map { |a, b, c| [b, @adapters[c] - @adapters[a] <= 3] }
           .select(&:last)
           .map(&:first)

result = grouped(skippable_indexes).map { |group| count_legal_combinations(group) }.reduce(&:*)
debug result

raise unless result == 6_044_831_973_376
