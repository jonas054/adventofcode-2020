task :default do
  sh 'rubocop -A --disable-uncorrectable 18*.rb'
  ruby '-I. -rrainbow -rdebugging 18.rb'
  ruby '-I. -rrainbow -rdebugging 18b.rb'
end

task :fifteen do
  sh 'g++ -O2 15b.cpp'
  sh './a.out'
end
