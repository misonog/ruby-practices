# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_strike
    frame = Frame.new(['X'], 0)
    assert frame.strike?

    frame = Frame.new(%w[4 5], 0)
    assert !frame.strike?
  end

  def test_spare
    frame = Frame.new(%w[5 5], 0)
    assert frame.spare?

    frame = Frame.new(['X'], 0)
    assert !frame.spare?

    frame = Frame.new(%w[4 5], 0)
    assert !frame.spare?
  end

  def test_calc_score_until_num_of_shot
    frame = Frame.new(%w[5 5], 0)
    assert_equal 5, frame.calc_score_until_num_of_shot(1)

    frame = Frame.new(%w[4 5 X], 0)
    assert_equal 9, frame.calc_score_until_num_of_shot(2)
  end
end
