class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
	@guesses = ''
	@wrong_guesses = ''
  end

  # Decision function 
  #
  # Deciedes whether or not the player has lost the game
  def check_win_or_lose
	if @wrong_guesses.length >= 7
		return :lose
	end
	
	if @word.chars.all? { |char| @guesses.include?(char) }
		return :win
	end
	
	return :play
  end

  def word_with_guesses
	ret = ""
	@word.split("").each do |i|
		if @guesses.include?(i)
			ret += i
		else
			ret += '-'
		end
	end
	return ret
  end	

  # Guess function
  #
  # Checks for a valid letter input, compares to word, than checks if wrong
  # guess has been done before 
  def guess(letter)
	if letter.to_s.empty? || !letter.match(/^[a-zA-Z]+S/)
		raise ArgumentError
	end
		
	# check if letter is in word
	if @word.downcase.include?(letter.downcase)
		if !@guesses.include?(letter.downcase)
			@guesses += letter.downcase
			return true
		end
		return false
	# check if letter is apart of the wrong guesses
	elsif !@wrong_guesses.include?(letter.downcase)
		@wrong_guesses += letter.downcase
		return true
	end
	return false
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end
