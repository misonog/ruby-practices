# frozen_string_literal: true

class Shot
  attr_reader :score

  STRIKE_MARK = 'X'
  MAX_PINS = 10

  def initialize(mark)
    @score = convert_to_score(mark)
  end

  def strike?
    @score == MAX_PINS
  end

  private

  def convert_to_score(mark)
    mark == STRIKE_MARK ? MAX_PINS : mark.to_i
  end
end
