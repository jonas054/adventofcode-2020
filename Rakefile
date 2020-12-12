task :default do
  ruby '-I. -rrainbow -rdebugging 10b.rb'
  sh 'rubocop -A --disable-uncorrectable 10*.rb'
end
