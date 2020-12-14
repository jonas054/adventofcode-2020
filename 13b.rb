def run(schedule)
  buses = parse(schedule)
  time = 0
  step = 1
  (2..buses.size).each do |subset_size|
    subset = buses[0, subset_size]
    time = find_time(time, step, subset)
    step = subset.map(&:first).reduce(&:*)
  end
  time
end

def parse(schedule)
  schedule
    .split(/,/)
    .each_with_index
    .reject { |id, _| id == 'x' }
    .map { |id, ix| [id.to_i, ix] }
end

def find_time(start, step, buses)
  start.step(100_000 * step, step).find do |t|
    buses.all? { |id, ix| (t + ix) % id == 0 }
  end
end

info run('7,13,x,x,59,x,31,19') == 1_068_781
info run('17,x,13,19') == 3417
info run('67,7,59,61') == 754_018
info run('67,x,7,59,61') == 779_210
info run('67,7,x,59,61') == 1_261_476
info run('1789,37,47,1889') == 1_202_161_486

debug run(File.read('13.txt').lines.last.strip) == 667_437_230_788_118
