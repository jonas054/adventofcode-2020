# input = <<~INPUT
#   0: 4 1 5
#   1: 2 3 | 3 2
#   2: 4 4 | 5 5
#   3: 4 5 | 5 4
#   4: "a"
#   5: "b"

#   ababbb
#   bababa
#   abbbab
#   aaabbb
#   aaaabbb
# INPUT

def main
  input = File.read('19.txt')
  messages, rules = parse(input)
  debug messages.select { |m| ok?(rules, m) }.size # 178
end

def parse(input) # rubocop:todo Metrics/MethodLength
  rules = {}
  messages = []
  input.lines.map(&:chomp).each do |line|
    case line
    when /(\d+): ([" \w|]+)/
      rules[$1.to_i] = AnyOf.new(
        $2.split(/ \| /).map do |s|
          SequenceOf.new(s.split.map { |e| e =~ /\d/ ? e.to_i : e.gsub(/"/, '') })
        end
      )
    when /^[a-z]+$/
      messages << line
    end
  end
  [messages, rules]
end

def ok?(rules, message)
  $rules = rules # rubocop:todo Style/GlobalVars
  rules[0].matching_length(message) == message.length
end

AnyOf = Struct.new(:elements) do
  def matching_length(msg)
    elements.map { |e| matching_length_for(e, msg) }.max
  end
end

SequenceOf = Struct.new(:elements) do
  def matching_length(msg)
    elements.reduce(0) do |a, e|
      next_bit = matching_length_for(e, msg[a..-1])
      break 0 if next_bit == 0

      a + next_bit
    end
  end
end

def matching_length_for(e, msg)
  return e.matching_length(msg) if e.respond_to?(:matching_length)

  case e
  when Integer then $rules[e].matching_length(msg) # rubocop:todo Style/GlobalVars
  when String then msg.start_with?(e) ? e.length : 0
  end
end

main
