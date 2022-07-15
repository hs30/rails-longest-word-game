require 'open-uri' # package
require 'json'
class GamesController < ApplicationController
  # group :development, :test do
  #   # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  #   gem 'pry-byebug'
  # end

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @valid_word = valid_word?(@word)
    @score = word_within_letters?(@valid_word, @letters)
  end

  private

  def word_within_letters?(word, letters)
    word.split.each do |letter|
      letters.all?(letter)
    end
  end

  def valid_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end

# Notes
# .split .each and .include

# word.split.each do |letter|
#   letters.included?(letter)
# end

# def english_word?(word)
#   response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
#   json = JSON.parse(response.read)
#   return json['found']
# end
