# frozen_string_literal: true

require 'json'
require 'open-uri'

# top-level documentation class comment
class GamesController < ApplicationController
  def new
    # create an array of random letters
    @grid = []
    rand(5..20).times do
      @grid << ('A'..'Z').to_a.sample
    end
    # get the input from the user
  end

  def score
    word_grid_match = validate_letters?(params[:word], params[:grid])
    word_is_english = validate_word?(params[:word])

    score = params[:word].length * 3

    @message = if word_is_english && word_grid_match
                 "Amazing! you got #{score} points for #{params[:word]}"
               elsif word_is_english
                 "Sorry, #{params[:word]} cannot be build from #{params[:grid]}!"
               else
                 "Sorry, #{params[:word]} is not an english word!"
               end
  end

  private

  def validate_letters?(word, grid)
    word_letters = Hash.new(0)
    word.upcase.split(//).each do |letter|
      word_letters[letter] += 1
    end

    grid_letters = Hash.new(0)
    grid.split(' ').each do |letter|
      grid_letters[letter] += 1
    end

    word_letters.keys.all? { |key| word_letters[key] <= grid_letters[key] }
  end

  def validate_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    file = open(url).read
    file_parsed = JSON.parse(file)

    file_parsed['found']
  end
end
