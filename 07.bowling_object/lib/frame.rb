# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :score

  def initialize(marks)
    @shots = marks.map { |mark| Shot.new(mark) }
    @score = @shots.sum(&:score)
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    !strike? && @score == Shot::MAX_SCORE
  end

  def calc_score_until_num_of_shot(num)
    @shots[0, num].sum(&:score)
  end
end
