# frozen_string_literal: true

require_relative 'shot'

class Frame
  STRIKE_MARK = 'X'
  MAX_SCORE = 10

  def initialize(frame)
    @frame = frame
  end

  def score
    @frame.sum { |shot| Shot.new(shot).score }
  end

  def strike?
    @frame[0] == STRIKE_MARK
  end

  def spare?
    !strike? && score == MAX_SCORE
  end
end
