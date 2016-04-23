#!/usr/bin/env ruby
regex = ARGV[0].to_s

# Find files with names that matches regex
result = `find . -regextype posix-extended -regex ".*/#{regex}\.(html|rb|erb|js|css|yml|txt)"`.split("\n").sort
# Print results of find function
puts "Files with names that matches <" + regex + ">"
unless result.empty?
  result.each do |r|
    puts "  " + r
  end
end

# Printing divider
puts "*"*50

# Find files with content that matches regex
files = `find . -regextype posix-extended -regex ".*/.*\.(html|rb|erb|js|css|yml|txt)"`.split("\n").sort
puts "Files with content that matches <" + regex + ">"
files.each do |file_path|
  file_contents = `grep #{file_path} -in -e "#{regex}"`.split("\n")
  unless file_contents.empty?
    puts file_path.to_s
    file_contents.each do |c|
      puts "  " + c.to_s
    end
    puts "-"*50
  end
end
