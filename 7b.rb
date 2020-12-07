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

# input2 = <<~INPUT
#   shiny gold bags contain 2 dark red bags.
#   dark red bags contain 2 dark orange bags.
#   dark orange bags contain 2 dark yellow bags.
#   dark yellow bags contain 2 dark green bags.
#   dark green bags contain 2 dark blue bags.
#   dark blue bags contain 2 dark violet bags.
#   dark violet bags contain no other bags.
# INPUT

input = File.read('7.txt')

@table = Hash.new([])

input.lines.map(&:chomp).each do |line|
  raise line unless line =~ /([a-z]+ [a-z]+) bags contain (.*)\./

  outer_color, contents = $1, $2.split(/, */)
  contents.each { |c| @table[outer_color] += [[$1.to_i, $2]] if c =~ /(\d+) ([a-z]+ [a-z]+) bags?/ }
end

def count_bags_inside(outer_color)
  @table[outer_color].map { |count, color| count + count * count_bags_inside(color) }.sum
end

debug count_bags_inside('shiny gold') # 172246
