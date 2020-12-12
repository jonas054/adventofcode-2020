task :default do
  sh 'rubocop -A --disable-uncorrectable 11*.rb'
  ruby '-I. -rrainbow -rdebugging 11b.rb'
end
