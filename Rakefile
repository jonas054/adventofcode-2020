task :default do
  ruby '-I. -rrainbow -rdebugging 4b.rb'
  sh 'rubocop -A --disable-uncorrectable 4*.rb'
end
