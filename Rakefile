task :default do
  ruby '-I. -rrainbow -rdebugging 3b.rb'
  sh 'rubocop -A --disable-uncorrectable 3*.rb'
end
