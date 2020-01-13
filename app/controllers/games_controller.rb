class GamesController < ApplicationController
  require "open-uri"
  def new
    abc = ('A'..'Z').to_a
    vowels = ['A', 'E', 'I', 'O', 'U']
    word_length = rand(4..10)

    @letters = []
    word_length.times { @letters.push(abc.sample()) }
    @letters.push (vowels.sample())
  end

  def score
    # binding.pry
    @word = params[:word]
    @letters = params[:letters]
    @responseVal = ""
    @score = 0
    #check if @word is valid  w/three scenarios
    #cant be built
    if !buildable(@word, @letters)
      @responseVal = "Sorry but #{@word.upcase} can't be built out of #{@letters.split(' ').join(', ')}"
      @score = 0
    elsif !english(@word)
      @responseVal = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
      @score = 0
    else
      @responseVal = "Contratulations! #{@word.upcase} is a valid English word!"
      @score = calc_score(@word, @letters)
    end

    #built but not valid

    #valid and builable
  end

  def english(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json["found"]
  end

def buildable(word, letters)
  word_count =  Hash[word.upcase.split('').group_by{ |c| c }.map{ |k, v| [k, v.size] }]
  p letters
  letter_count =  Hash[letters.split(' ').group_by{ |c| c }.map{ |k, v| [k, v.size] }]
  response = true
  word_count.each do |k, v|
    if (letter_count[k].nil? || v > letter_count[k])
      response = false
      break
    end
  end
  return response
end

def calc_score(word, letters)
  act_length = word.length
  max_length = letters.split(' ').join('').length
  return act_length**3 - max_length**2
end

end
