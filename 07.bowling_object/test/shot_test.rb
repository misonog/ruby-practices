# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_when_mark_is_not_x
    shot = Shot.new('0')
    assert_equal 0, shot.score
  end

  def test_when_mark_is_x
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end
end
