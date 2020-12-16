task :default do
  sh 'rubocop -A --disable-uncorrectable 15*.rb'
  ruby '-I. -rrainbow -rdebugging 15.rb'
end

task :fifteen do
  sh 'g++ -O2 15b.cpp'
  sh './a.out'
end
