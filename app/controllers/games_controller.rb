class GamesController < ApplicationController
  def new
    abc = ('A'..'Z').to_a
    word_length = rand(4..10)

    @letters = []
    word_length.times { @letters.push(abc.sample()) }
  end

  def score
  end
end
