# input = <<~INPUT
#   light red bags contain 1 bright white bag, 2 muted yellow bags.
#   dark orange bags contain 3 bright white bags, 4 muted yellow bags.
#   bright white bags contain 1 shiny gold bag.
#   muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
#   shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
#   dark olive bags contain 3 faded blue bags, 4 dotted black bags.
#   vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
#   faded blue bags contain no other bags.
#   dotted black bags contain no other bags.
# INPUT

input = File.read('7.txt')

@table = Hash.new([])

input.lines.map(&:chomp).each do |line|
  raise line unless line =~ /([a-z]+ [a-z]+) bags contain (.*)\./

  outer_color, contents = $1, $2.split(/, */)
  contents.each do |c|
    @table[$1] += [outer_color] if c =~ /\d+ ([a-z]+ [a-z]+) bags?/
  end
end

def possible_containers(color)
  (@table[color] + @table[color].map { |c| possible_containers(c) }.flatten).uniq
end

debug possible_containers('shiny gold').size
