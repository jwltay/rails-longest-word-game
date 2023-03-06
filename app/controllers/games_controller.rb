class GamesController < ApplicationController
  def new
    all_letters = Array('A'..'Z')
    @letters = Array.new(10) { all_letters.sample }
  end

  def score
    raise
  end
end
