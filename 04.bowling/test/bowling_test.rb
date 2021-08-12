# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/bowling'

class BowlingTest < Minitest::Test
  def test_parse_score
    assert_equal [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 6, 4, 5], parse_score('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 10, 10, 10], parse_score('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal [0, 10, 1, 5, 0, 0, 0, 0, 10, 10, 10, 5, 1, 8, 1, 0, 4], parse_score('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 10, 0, 0], parse_score('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10], parse_score('X,X,X,X,X,X,X,X,X,X,X,X')
  end

  def test_convert_frames
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]],
                 convert_to_frames([6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 6, 4, 5])
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10, 10, 10]],
                 convert_to_frames([6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 10, 10, 10])
    assert_equal [[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]],
                 convert_to_frames([0, 10, 1, 5, 0, 0, 0, 0, 10, 10, 10, 5, 1, 8, 1, 0, 4])
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [10, 0, 0]],
                 convert_to_frames([6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 10, 0, 0])
    assert_equal [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]],
                 convert_to_frames([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10])
  end

  def test_strike_score
    assert_equal 20, calc_strike_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], 5)
    assert_equal 20, calc_strike_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], 8)
    assert_equal 30, calc_strike_score([[0, 10], [1, 5], [0, 0], [0, 0], [10], [10], [10], [5, 1], [8, 1], [0, 4]], 4)
    assert_equal 30, calc_strike_score([[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]], 8)
  end

  def test_calc_spare_score
    assert_equal 17, calc_spare_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], 3)
    assert_equal 20, calc_spare_score([[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], 4)
  end
end
