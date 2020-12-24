require 'set'

DEPTH = 5

input = File.read('19.txt')

def main(input)
  messages, rules = parse(input)
  rules[8] = Set.new((1..DEPTH).map { |d| [42] * d })
  rules[11] = Set.new((1..DEPTH).map { |d| [42] * d + [31] * d })
  debug messages.grep(/^#{to_regexp(rules, rules[0])}$/).size # 346
end

def parse(input)
  lines = input.lines.map(&:chomp)
  rules = {}
  lines.each { |line| rules[$1.to_i] = parse_rule($2) if line =~ /(\d+): ([" \w|]+)/ }
  [lines.grep(/^[ab]+$/), rules]
end

def parse_rule(r)
  r.start_with?('"') ? r[1..-2] : Set.new(r.split(/ \| /).map { |s| s.split.map(&:to_i) })
end

def to_regexp(rules, rule)
  case rule
  when String then rule
  when Integer then to_regexp(rules, rules[rule])
  when Array then rule.map { |e| "(#{to_regexp(rules, e)})" }.join
  when Set then rule.map { |e| to_regexp(rules, e) }.join('|')
  end
end

main(input)
