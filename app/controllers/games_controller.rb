require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    all_letters = Array('A'..'Z')
    @letters = Array.new(10) { all_letters.sample }
  end

  def score
    @guess = params[:word]
    @grid = params[:letters]
    if word_valid? && word_in_grid?
      @score = "Congratulations! #{@guess.upcase} is a valid word!"
    elsif word_in_grid?
      @score = "Sorry, #{@guess.upcase} does not seem to be a valid English word..."
    else
      @score = "Sorry, #{@guess.upcase} can't be built out of #{@grid}"
    end
  end

  private

  def word_valid?
    data = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}").read)
    data['found'] == true
  end

  def word_in_grid?
    combinations = @grid.split(' ').permutation(@guess.length).map { |e| e }
    combinations.include?(@guess.upcase.chars)
  end
end
