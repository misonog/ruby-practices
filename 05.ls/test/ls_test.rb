# frozen_string_literal: true

require 'minitest/autorun'
require './05.ls/lib/ls'

class LSTest < Minitest::Test
  def test_generate_path_list
    expected = %w[testdir bar.rb .hoge foo.md .. .]
    actual = LS.generate_path_list('./05.ls/testdata')
    assert_equal expected, actual
  end
end
