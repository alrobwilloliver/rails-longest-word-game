require 'time'
require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
  	array = Array("a".."z")
  	cookies[:@grid] = Array.new(10) { array.sample }
  	cookies[:time_start] = Time.now
  end

  def score
  	@answer = params[:answer]
  	url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
  	words_serialized = open(url).read
  	word = JSON.parse(words_serialized)
  	@score = 0
  	if word["found"]
  	  @score += 5
  	  @score += word["word"].length
  	end
  	word_array = word['word'].scan /\w/
  	match = word_array.any? { |i| word_array.include? i }
  	if match
  	  @score += 3
  	else
  	  @score = 0
  	end
  end
end
