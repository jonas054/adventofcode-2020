def debug(*args)
  puts Rainbow(*args).yellow
end

def info(*args)
  puts Rainbow(*args).cyan
end

def warning(*args)
  puts Rainbow(*args).pink
end

def error(*args)
  puts Rainbow(*args).red
end
