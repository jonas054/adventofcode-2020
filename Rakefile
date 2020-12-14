task :default do
  sh 'rubocop -A --disable-uncorrectable 13*.rb'
  ruby '-I. -rrainbow -rdebugging 13b.rb'
end
