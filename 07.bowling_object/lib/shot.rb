# frozen_string_literal: true

class Shot
  STRIKE_MARK = 'X'
  MAX_SCORE = 10

  def initialize(mark)
    @mark = mark
  end

  def score
    @mark == STRIKE_MARK ? MAX_SCORE : @mark.to_i
  end
end
