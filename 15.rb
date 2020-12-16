input = [0, 3, 6]
# input = [0, 13, 1, 16, 6, 17]

input.each_with_index do |number, ix|
  puts "#{ix + 1}: #{number}"
end

((input.size + 1)..30_000_000).each do |turn|
  ix = input[0..-2].rindex(input.last)
  input << if ix
             input.size - ix - 1
           else
             0
           end
  puts "#{turn}: #{input.last}"
end
