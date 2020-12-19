require '18'

def main
  check('1 + (2 * 3) + (4 * (5 + 6))', 51)
  check('2 * 3 + (4 * 5)', 46)
  check('5 + (8 * 3 + 9 + 3 * 4 * 3)', 1445)
  check('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))', 669_060)
  check('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2', 23_340)

  debug @input.lines.map { |line| calc(line) }.sum
end

alias old_evaluate_plus_or_times evaluate_plus_or_times

def evaluate_plus_or_times(expression)
  ix = expression.index('+')
  if ix
    result = expression.dup
    result[ix - 1, 3] = expression[ix - 1] + expression[ix + 1]
    evaluate(result)
  else
    old_evaluate_plus_or_times(expression)
  end
end

main
