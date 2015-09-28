class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word, :wrong_guesses, :guesses
  
  def guess(letter)
    
    letters = @word.chars
    guesses = @guesses.chars
    wrongs = @wrong_guesses.chars
    
    raise ArgumentError, 'Argument error' unless letter != nil
    raise ArgumentError, 'Argument error' unless !letter.match(/[^[:alnum:]]/)
    raise ArgumentError, 'Argument error' unless letter != ""
    
    if (/[[:upper:]]/.match(letter) != nil)
      return false
    end
    
    guesses.each do |w|
      if (letter == w)
        return false
      end
    end
    wrongs.each do |x|
      if (letter == x)
        return false
      end
    end
    letters.each do |y|
      if (letter == y)
        @guesses += letter
        return
      end
    end
    @wrong_guesses += letter
    
  end

  def word_with_guesses
    guesses = @guesses.chars
    display = ""
    ismatch = false
    
    (1..@word.length).each do |n|
      guesses.each do |x|
        if x == @word[n-1]
          ismatch = true
        end
      end
      
      if ismatch
        display += @word[n-1]
      else
        display += "-"
      end
      
      ismatch = false
    end
    return display
  end

  def check_win_or_lose
    win = true
    guessedWord = word_with_guesses.chars
    guessedWord.each do |x|
      if x.match(/[^[:alnum:]]/)
        win = false
      end
    end
    if wrong_guesses.length == 7 && win == false 
      return :lose
    elsif wrong_guesses.length < 7 && win == false
      return :play
    elsif win == true
      return :win
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
