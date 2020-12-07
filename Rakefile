task :default do
  ruby '-I. -rrainbow -rdebugging 7b.rb'
  sh 'rubocop -A --disable-uncorrectable 7*.rb'
end
