
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  self.per_form_csrf_tokens = true

  def new
    @letters = (0...8).map { (65 + rand(26)).chr }

  end

  def score
    @word = params["word"]

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"

    word_serialized = open(url).read
    @word = JSON.parse(word_serialized)


  end
end
