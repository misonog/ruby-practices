# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls'

class LSTest < Minitest::Test
  def test_default_format
    file_stats = LS.generate_file_stats_class('./05.ls/testdata')
    formatter = LS::Formatter.new(file_stats)
    actual = formatter.render

    expected = <<~TEXT.chomp
      bar.txt  foo.md  testdir
    TEXT
    assert_equal expected, actual
  end

  def test_all_file_format
    file_stats = LS.generate_file_stats_class('./05.ls/testdata')
    formatter = LS::Formatter.new(file_stats, all: true)
    actual = formatter.render

    expected = <<~TEXT.chomp
      .   bar.txt  .hoge#{'  '}
      ..  foo.md   testdir
    TEXT
    assert_equal expected, actual
  end

  def test_reverse_format
    file_stats = LS.generate_file_stats_class('./05.ls/testdata/testdir')
    formatter = LS::Formatter.new(file_stats, reverse: true)
    actual = formatter.render

    expected = <<~TEXT.chomp
      foo.txt  bar.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_listing_format
    file_stats = LS.generate_file_stats_class('./05.ls/testdata/testdir')
    formatter = LS::Formatter.new(file_stats, all: true, long: true)
    actual = formatter.render

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 3 misono misono 4096 Aug 15 16:59 .
      drwxr-xr-x 5 misono misono 4096 Aug 14 19:40 ..
      -rwxr--r-- 1 misono misono    0 Aug 15 16:59 bar.txt
      -rw-r--r-- 1 misono misono  446 Aug 14 19:46 foo.md
      -rw-r--r-- 1 misono misono    0 Aug 14 19:41 .hoge
      drwxr-xr-x 2 misono misono 4096 Aug 16 19:54 testdir
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_reverse_format
    file_stats = LS.generate_file_stats_class('./05.ls/testdata')
    formatter = LS::Formatter.new(file_stats, all: true, long: true, reverse: true)
    actual = formatter.render

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 2 misono misono 4096 Aug 16 19:54 testdir
      -rw-r--r-- 1 misono misono    0 Aug 14 19:41 .hoge
      -rw-r--r-- 1 misono misono  446 Aug 14 19:46 foo.md
      -rwxr--r-- 1 misono misono    0 Aug 15 16:59 bar.txt
      drwxr-xr-x 5 misono misono 4096 Aug 14 19:40 ..
      drwxr-xr-x 3 misono misono 4096 Aug 15 16:59 .
    TEXT
    assert_equal expected, actual
  end
end
