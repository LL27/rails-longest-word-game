
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  self.per_form_csrf_tokens = true

  def new
    @letters = (0...8).map { (65 + rand(26)).chr }
  end

  def score
    @word = params[:word]


    @letters = params[:grid]


    if is_included_in_grid?(@word, @letters) == false
      @result = "Letters are not included in the grid"
    else
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      word_serialized = open(url).read
      @word = JSON.parse(word_serialized)

      if @word["found"] == false
        @result = "Word not found"
      else
        @result = "Your word is #{@word["word"]}/n
                    Time taken to answer: /n
        "
      end
    end
  end

  private

  def is_included_in_grid?(word, letters)
    word = word.upcase
    word.chars.all? do |char|
      word.chars.count(char) <= letters.count(char)
    end
  end




end
