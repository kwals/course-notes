class Hangman
  attr_reader :guesses_left, :guesses

  Words = File.
    read("/usr/share/dict/words").
    split("\n").
    select { |w| w.length < 8 && w.length > 1 }.
    map { |w| w.chomp }

  def initialize opts={}
    @guesses_left = opts[:guesses_left] || 6
    @guesses      = opts[:guesses] || []
    @answer       = opts[:answer] || Words.sample
  end

  def check_guess guess
    @guesses.push guess
    unless @answer.include? guess
      @guesses_left -= 1
    end

    "#{board}     Guesses left: #{guesses_left}"
  end

  def board
    result = ""
    @answer.split("").each do |letter|
      if @guesses.include? letter
        result += letter
      else
        result += "_"
      end
    end
    result
  end

  def lost?
    @guesses_left == 0
  end

  # include Winnable
  def over?
    won? || lost?
  end

  def won?
    board == @answer
  end

  def answer
    @answer
  end

  # def guesses_left
  #   @guesses_left
  # end
end