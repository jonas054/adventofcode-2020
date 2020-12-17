task :default do
  sh 'rubocop -A --disable-uncorrectable 17*.rb'
  ruby '-I. -rrainbow -rdebugging 17b.rb'
end

task :fifteen do
  sh 'g++ -O2 15b.cpp'
  sh './a.out'
end
