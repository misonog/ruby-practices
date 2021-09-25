# frozen_string_literal: true

class Shot
  attr_reader :score

  STRIKE_MARK = 'X'
  MAX_SCORE = 10

  def initialize(mark)
    @score = convert_to_score(mark)
  end

  private

  def convert_to_score(mark)
    mark == STRIKE_MARK ? MAX_SCORE : mark.to_i
  end
end
