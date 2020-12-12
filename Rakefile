task :default do
  sh 'rubocop -A --disable-uncorrectable 12*.rb'
  ruby '-I. -rrainbow -rdebugging 12b.rb'
end
