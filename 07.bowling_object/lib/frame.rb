# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :num_of_knocked_down_pins, :index

  MAX_FRAME_INDEX = 9

  def initialize(marks, index)
    @shots = marks.map { |mark| Shot.new(mark) }
    @num_of_knocked_down_pins = @shots.sum(&:score)
    @index = index
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    !strike? && @num_of_knocked_down_pins == Shot::MAX_PINS
  end

  def calc_score_until_num_of_shot(num)
    @shots[0, num].sum(&:score)
  end

  def last?
    @index == MAX_FRAME_INDEX
  end
end
