invalid_passports = <<~INPUT
  eyr:1972 cid:100
  hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

  iyr:2019
  hcl:#602927 eyr:1967 hgt:170cm
  ecl:grn pid:012533040 byr:1946

  hcl:dab227 iyr:2012
  ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

  hgt:59cm ecl:zzz
  eyr:2038 hcl:74454a iyr:2023
  pid:3556412378 byr:2007
INPUT

valid_passports = <<~INPUT
  pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
  hcl:#623a2f

  eyr:2029 ecl:blu cid:129 byr:1989
  iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

  hcl:#888785
  hgt:164cm byr:2001 iyr:2015 cid:88
  pid:545766238 ecl:hzl
  eyr:2022

  iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
INPUT

input = File.read('4.txt')

REQUIRED = %w[byr iyr eyr hgt hcl ecl pid].freeze

def scan(input) # rubocop:todo Metrics/MethodLength
  fields = []
  passports = []
  input.lines.each do |line|
    case line.strip
    when ''
      passports << fields
      fields = []
    when /[a-z]{3}:/
      fields += line.scan(/\b[a-z]{3}:\S+/)
    else
      raise line.inspect
    end
  end
  passports << fields
end

def valid_passport?(doc)
  bits = doc.map { |data| data.split(':') }
  return false if (REQUIRED - bits.map(&:first)).any?

  bits.all? { |pair| valid?(*pair) }
end

RANGES = {
  'byr' => 1920..2002,
  'iyr' => 2010..2020,
  'eyr' => 2020..2030,
  'hcl' => /^#[0-9a-f]{6}$/,
  'pid' => /^\d{9}$/,
  'ecl' => /^amb|blu|brn|gry|grn|hzl|oth$/
}.freeze

def valid?(key, value) # rubocop:todo Metrics/CyclomaticComplexity
  case key
  when 'byr', 'iyr', 'eyr' then RANGES[key].include?(value.to_i)
  when 'hcl', 'pid', 'ecl' then value =~ RANGES[key]
  when 'cid' then true
  when 'hgt'
    value =~ /^(\d+)(cm|in)$/ && ($2 == 'cm' && (150..193).include?($1.to_i) ||
                                  $2 == 'in' && (59..76).include?($1.to_i))
  end
end

debug scan(invalid_passports).count { |doc| valid_passport?(doc) }.to_i # 0
debug scan(valid_passports).count { |doc| valid_passport?(doc) }.to_i # 4
debug scan(input).count { |doc| valid_passport?(doc) }.to_i # 121
