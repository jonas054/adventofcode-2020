task :default do
  ruby '-I. -rrainbow -rdebugging 5.rb'
  sh 'rubocop -A --disable-uncorrectable 5*.rb'
end
