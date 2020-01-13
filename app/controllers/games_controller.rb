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
    @word = params[:word || ""].upcase
    @letters = params[:letters].split
    @responseVal = ""
    @included = buildable?(@word, @letters)
    @english_word =  english_word?(@word)
    @score = calc_score(@word, @letters, @english_word, @included)
    #check if @word is valid  w/three scenarios
    #cant be built

  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json["found"]
  end

def buildable?(word, letters)
  word_count =  Hash[word.split('').group_by{ |c| c }.map{ |k, v| [k, v.size] }]
  p letters
  letter_count =  Hash[letters.group_by{ |c| c }.map{ |k, v| [k, v.size] }]
  response = true
  word_count.each do |k, v|
    if (letter_count[k].nil? || v > letter_count[k])
      response = false
      break
    end
  end
  return response
end

def calc_score(word, letters, english_word, includedVal)
  if english_word && includedVal
    act_length = word.length
    max_length = letters.split(' ').join('').length
    return act_length**3 - max_length**2
  else
    return 0
  end
end

end
