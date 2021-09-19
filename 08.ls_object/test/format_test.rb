# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'
require_relative '../lib/ls/format'

class FormatTest < Minitest::Test
  def test_default_format
    file_stats = LS.generate_file_stats_class('./08.ls_object/testdata')
    format = LS::Format.new(file_stats)
    actual = format.render

    expected = <<~TEXT.chomp
      bar.txt  foo.md  testdir
    TEXT
    assert_equal expected, actual
  end

  def test_all_file_format
    file_stats = LS.generate_file_stats_class('./08.ls_object/testdata')
    format = LS::Format.new(file_stats, all: true)
    actual = format.render

    expected = <<~TEXT.chomp
      .   bar.txt  .hoge#{'  '}
      ..  foo.md   testdir
    TEXT
    assert_equal expected, actual
  end

  def test_reverse_format
    file_stats = LS.generate_file_stats_class('./08.ls_object/testdata/testdir')
    format = LS::Format.new(file_stats, reverse: true)
    actual = format.render

    expected = <<~TEXT.chomp
      foo.txt  bar.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_listing_format
    file_stats = LS.generate_file_stats_class('./08.ls_object/testdata/testdir')
    format = LS::Format.new(file_stats, all: true, long: true)
    actual = format.render

    expected = <<~TEXT.chomp
      total 8
      drwxr-xr-x 2 misono misono 4096 Sep 19 09:09 .
      drwxr-xr-x 3 misono misono 4096 Sep 19 09:00 ..
      -rw-r--r-- 1 misono misono    0 Sep 19 08:59 bar.txt
      -rw-r--r-- 1 misono misono    0 Sep 19 08:59 foo.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_reverse_format
    file_stats = LS.generate_file_stats_class('./08.ls_object/testdata')
    format = LS::Format.new(file_stats, all: true, long: true, reverse: true)
    actual = format.render

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 2 misono misono 4096 Sep 19 09:09 testdir
      -rw-r--r-- 1 misono misono    0 Sep 19 08:59 .hoge
      -rw-r--r-- 1 misono misono  446 Sep 19 09:00 foo.md
      -rw-r--r-- 1 misono misono    0 Sep 19 08:59 bar.txt
      drwxr-xr-x 5 misono misono 4096 Sep 19 09:11 ..
      drwxr-xr-x 3 misono misono 4096 Sep 19 09:00 .
    TEXT
    assert_equal expected, actual
  end
end
