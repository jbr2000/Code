class HomeController < ApplicationController
  load "#{Rails.root}/lib/ladder.rb"
  def index
    # Assign starting and ending words
    # dictionary loaded by ladder.rb
    loop do
      @word_0 = dictionary[rand(dictionary.size-1)]
      @word_6 = dictionary[rand(dictionary.size-1)]
      break if not (@word_0.eql?(@word_6))
    end
  end

  def results
    @invalid_words = Array.new
    @words = params.values.slice(1..7)
    @words.delete_if {|w| not dictionary.include?(w)}
  end
end
