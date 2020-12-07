task :default do
  ruby '-I. -rrainbow -rdebugging 6b.rb'
  sh 'rubocop -A --disable-uncorrectable 6*.rb'
end
