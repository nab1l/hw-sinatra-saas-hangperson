class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    if letter == nil or letter == '' or !(/[[:alpha:]]/ =~ letter)
      raise ArgumentError
    end
    letter.downcase!
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false
    end
    if @word.include? letter
      @guesses << letter
      return true
    else
      @wrong_guesses << letter
      return true
    end
    return false
  end
  
   def word_with_guesses
      @word.chars.map{|x| (guesses.include? x) ? x:"-"}.join
   end
   
    def check_win_or_lose
      if word_with_guesses == @word
        return :win
      elsif @wrong_guesses.length > 6
        return :lose
      else
        return :play
      end
    end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
