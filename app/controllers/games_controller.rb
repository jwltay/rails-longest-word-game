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
      @score = 'valid'
    elsif word_valid?
      @score = 'word in dictionary but not grid'
    elsif word_in_grid?
      @score = 'word in grid but not dictionary'
    else
      @score = 'please submit a valid word from the grid'
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
