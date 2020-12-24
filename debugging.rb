def debug(*args)
  puts '  ' * (caller.length - 1) + Rainbow(*args).yellow
end

def info(*args)
  puts '  ' * (caller.length - 1) + Rainbow(*args).cyan
end

def warning(*args)
  puts '  ' * (caller.length - 1) + Rainbow(*args).pink
end

def error(*args)
  puts '  ' * (caller.length - 1) + Rainbow(*args).red
end

def green(*args)
  puts '  ' * (caller.length - 1) + Rainbow(*args).green
end
