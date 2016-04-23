#!/usr/bin/env ruby
# --- Section Break ---
#c <temporary code>
#g <general comment>

# --- Import/populate dictionary ---
dictionary = Array.new
File.open("./words.txt", "r") do |f|
  f.each_line do |line|
    dictionary.push(line.chomp!)
  end
end



# --- Determine word size ---
word_size = Integer
loop do
  print "Enter word length between 5-20: "
  word_size = gets
  break if word_size.to_i.between?(5,20)
end
#g word deletion
dictionary.delete_if {|x| x.length != word_size.to_i}
status = Array.new(word_size.to_i, "_")



# --- Main Game Loop ---
chances = 10
guesses = Array.new
word = Array.new
cur_guess = String.new
loop do

#g recieve guess input with error handling
  loop do
    print "Enter guess: "
    cur_guess = gets.chomp!
#g eliminate repetative guesses
    break if ((/^[a-z]$/ === cur_guess) and not (guesses.include?(cur_guess.to_s)) and not (status.include?(cur_guess.to_s)))
    puts "!!! Invalid Guess !!!"
  end

#g remove words containing guess
  if word.empty?
    pending_deletions = 0
    dictionary.each {|x| if /.*#{cur_guess}.*/ === x then pending_deletions += 1 end}
    #c puts "Pending Deletions: #{pending_deletions}"
    #c puts "Dictionary Size: " + dictionary.size.to_s
#g check if dictionary is empty
    if pending_deletions == dictionary.size
      word = dictionary[rand(0..(dictionary.size-1))].to_s.split(//)
      word.each_with_index {|x, i| if x.to_s == cur_guess.to_s then status[i] = cur_guess.to_s end}
    else
#g finalize deletions
      dictionary.delete_if {|x| /.*#{cur_guess}.*/ === x}
      if dictionary.size == 1
        word = dictionary[0].to_s.split
      end
      guesses.push(cur_guess)
      chances -= 1
    end

#g check if guess is in word
  elsif word.include?(cur_guess.to_s)
    word.each_with_index {|x, i| if x.to_s == cur_guess.to_s then status[i] = cur_guess.to_s end}
  else
    guesses.push(cur_guess)
    chances -= 1
  end

#g print status
  guesses.sort!
  puts "Previous Incorrect Guesses: " + guesses.join(" ")
  puts "Status: " + status.join(" ")
  puts "Chances Remaining: #{chances}"
  #c puts "Word: <" + word.join + ">"
  print "\n" + "-"*50 + "\n\n"

#g lose condition
  if chances <= 0 
    puts "You lost fair and square..."
    if dictionary.size > 1
      puts "I didn't even have to pick a word yet! HAHA! I could have used any of these:"
      dictionary.each {|w| puts w}
    else
      puts "Word: <" + word.join + ">"
    end
    break
  end
#g win condition
  if word.join.eql?(status.join)
    puts "You Somehow Won!"
    break
  end
end
