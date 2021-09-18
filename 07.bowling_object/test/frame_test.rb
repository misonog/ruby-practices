# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_score
    frame = Frame.new(%w[4 5])
    assert_equal 9, frame.score

    frame = Frame.new(%w[6 4 5])
    assert_equal 15, frame.score

    frame = Frame.new(%w[X X X])
    assert_equal 30, frame.score
  end

  def test_strike
    frame = Frame.new(['X'])
    assert frame.strike?

    frame = Frame.new(%w[4 5])
    assert !frame.strike?
  end

  def test_spare
    frame = Frame.new(%w[5 5])
    assert frame.spare?

    frame = Frame.new(['X'])
    assert !frame.spare?

    frame = Frame.new(%w[4 5])
    assert !frame.spare?
  end
end
