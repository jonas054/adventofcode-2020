task :default do
  ruby '-I. -rrainbow -rdebugging 1b.rb'
  sh 'rubocop -A --disable-uncorrectable 1*.rb'
end
