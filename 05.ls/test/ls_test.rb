# frozen_string_literal: true

require 'minitest/autorun'
require './05.ls/lib/ls'

class LSTest < Minitest::Test
  def test_generate_path_list
    expected = %w[./05.ls/testdata/testdir ./05.ls/testdata/bar.rb ./05.ls/testdata/.hoge ./05.ls/testdata/foo.md ./05.ls/testdata/.. ./05.ls/testdata/.]
    actual = LS.generate_path_list('./05.ls/testdata')
    assert_equal expected, actual
  end
end
