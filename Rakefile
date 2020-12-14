task :default do
  sh 'rubocop -A --disable-uncorrectable 14*.rb'
  ruby '-I. -rrainbow -rdebugging 14b.rb'
end
