@input = File.read('18.txt')

def main
  check('1 + (2 * 3) + (4 * (5 + 6))', 51)
  check('2 * 3 + (4 * 5)', 26)
  check('5 + (8 * 3 + 9 + 3 * 4 * 3)', 437)
  check('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))', 12_240)
  check('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2', 13_632)

  debug @input.lines.map { |line| calc(line) }.sum
end

def check(string, expected)
  actual = calc(string)
  raise "Expected #{string} to be #{expected} but was #{actual}" unless actual == expected
end

def calc(string)
  expression = string.scan(/\d+|\S/).map { |elem| elem =~ /\d/ ? elem.to_i : elem }
  evaluate(expression)
end

def evaluate(expression)
  return expression.first if expression.length == 1
  return evaluate(evaluate_inner_parenthesis(expression)) if expression.include?('(')

  evaluate_plus_or_times(expression)
end

def evaluate_plus_or_times(expression)
  left, op, right = expression[0, 3]
  evaluate([left.send(op, right)] + expression[3..-1])
end

def evaluate_inner_parenthesis(expression)
  left_ix, right_ix = expression.each_with_index
                                .select { |e| %w[( )].include?(e.first) }
                                .each_cons(2)
                                .find { |a, b| a.first == '(' && b.first == ')' }
                                .map(&:last)
  result = expression.dup
  result[left_ix..right_ix] = evaluate(expression[left_ix + 1..right_ix - 1])
  result
end

main if $PROGRAM_NAME == __FILE__
