# input = <<~INPUT
#   1-3 a: abcde
#   1-3 b: cdefg
#   2-9 c: ccccccccc
# INPUT

input = File.read('2.txt')

def valid?(line)
  raise line unless line =~ /(\d+)-(\d+) (\w): (\w+)/

  pos1, pos2, letter, password = $1.to_i, $2.to_i, $3, $4
  (password[pos1 - 1] == letter) ^ (password[pos2 - 1] == letter)
end

debug(input.lines.count { |line| valid?(line) })

# 727
