# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/wc'

class WSTest < Minitest::Test
  def test_create_word_count_from_path
    word_counts = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt 06.wc/testdata/bar.md])
    word_counts.each do |w|
      assert_instance_of(WC::WordCount, w)
    end
  end

  def test_single_file_format
    wc = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt])
    format = WC::Format.new(wc)
    actual = format.render

    expected = <<-TEXT.chomp
  4  20 108 06.wc/testdata/foo.txt
    TEXT
    assert_equal expected, actual
  end

  def test_multi_files_format
    wc = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt 06.wc/testdata/bar.md])
    format = WC::Format.new(wc)
    actual = format.render

    expected = <<-TEXT.chomp
  4  20 108 06.wc/testdata/foo.txt
  5  20 103 06.wc/testdata/bar.md
  9  40 211 total
    TEXT
    assert_equal expected, actual
  end

  def test_single_file_line_option_format
    wc = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt])
    format = WC::Format.new(wc, lines: true)
    actual = format.render

    expected = <<~TEXT.chomp
      4 06.wc/testdata/foo.txt
    TEXT
    assert_equal expected, actual
  end

  def test_multi_files_line_option_format
    wc = WC.create_word_count_from_path(%w[06.wc/testdata/foo.txt 06.wc/testdata/bar.md])
    format = WC::Format.new(wc, lines: true)
    actual = format.render

    expected = <<-TEXT.chomp
  4 06.wc/testdata/foo.txt
  5 06.wc/testdata/bar.md
  9 total
    TEXT
    assert_equal expected, actual
  end
end
