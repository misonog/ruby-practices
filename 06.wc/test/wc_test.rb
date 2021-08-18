# frozen_string_literal: true

require 'minitest/autorun'
require './06.wc/lib/wc'

class WSTest < Minitest::Test
  def test_create_word_count_from_path
    word_counts = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt 06.wc/testdata/bar.md])
    word_counts.each do |w|
      assert_instance_of(WC::WordCount, w)
    end
  end
end
