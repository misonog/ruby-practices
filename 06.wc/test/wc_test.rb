# frozen_string_literal: true

require 'minitest/autorun'
require './06.wc/lib/wc'

class WSTest < Minitest::Test
  def test_read_files
    expected = [
      ["Lorem ipsum dolor sit amet\n", "Lorem ipsum dolor sit amet\n", "Lorem ipsum dolor sit amet\n", "Lorem ipsum dolor sit amet\n"],
      ["Almost before we knew it, we had left the ground.\n"]
    ]
    actual = WC.read_files(%w[06.wc/testdata/foo.txt 06.wc/testdata/bar.md])
    assert_equal expected, actual
  end
end
