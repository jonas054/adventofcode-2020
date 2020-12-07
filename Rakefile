task :default do
  ruby '-I. -rrainbow -rdebugging 2b.rb'
  sh 'rubocop -A --disable-uncorrectable 2*.rb'
end
