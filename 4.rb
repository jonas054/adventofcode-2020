# input = <<~INPUT
#   ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
#   byr:1937 iyr:2017 cid:147 hgt:183cm

#   iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
#   hcl:#cfa07d byr:1929

#   hcl:#ae17e1 iyr:2013
#   eyr:2024
#   ecl:brn pid:760753108 byr:1931
#   hgt:179cm

#   hcl:#cfa07d eyr:2025 pid:166559648
#   iyr:2011 ecl:brn hgt:59in
# INPUT

input = File.read('4.txt')

REQUIRED = %w[byr: iyr: eyr: hgt: hcl: ecl: pid:].freeze

fields = []
passports = []
input.lines.each do |line|
  case line.strip
  when ''
    passports << fields
    fields = []
  when /[a-z]{3}:/
    fields += line.scan(/\b[a-z]{3}:/)
  else
    raise line.inspect
  end
end
passports << fields

pp passports.map { |doc| REQUIRED - doc }.to_a
debug passports.count { |doc| (REQUIRED - doc).empty? }.to_i
