task :default do
  ruby '-I. -rrainbow -rdebugging 9b.rb'
  sh 'rubocop -A --disable-uncorrectable 9*.rb'
end
