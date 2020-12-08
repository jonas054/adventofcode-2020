task :default do
  ruby '-I. -rrainbow -rdebugging 8b.rb'
  sh 'rubocop -A --disable-uncorrectable 8*.rb'
end
