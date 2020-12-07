# input = <<~INPUT
#   1-3 a: abcde
#   1-3 b: cdefg
#   2-9 c: ccccccccc
# INPUT

input = File.read('2.txt')

def valid?(line)
  raise line unless line =~ /(\d+)-(\d+) (\w): (\w+)/

  min, max, letter, password = $1.to_i, $2.to_i, $3, $4
  (min..max).include?(password.count(letter))
end

debug(input.lines.count { |line| valid?(line) })

# 620
