# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_stat'
require_relative '../lib/format'

class FormatTest < Minitest::Test
  def generate_file_stats_classes(path)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    paths.map { |p| FileStat.new(p) }
  end

  def test_default_format
    file_stats = generate_file_stats_classes('./08.ls_object/testdata')
    format = Format.new(file_stats)
    actual = format.render

    expected = <<~TEXT.chomp
      bar.txt  foo.md  testdir
    TEXT
    assert_equal expected, actual
  end

  def test_all_file_format
    file_stats = generate_file_stats_classes('./08.ls_object/testdata')
    format = Format.new(file_stats, all: true)
    actual = format.render

    expected = <<~TEXT.chomp
      .   bar.txt  .hoge#{'  '}
      ..  foo.md   testdir
    TEXT
    assert_equal expected, actual
  end

  def test_reverse_format
    file_stats = generate_file_stats_classes('./08.ls_object/testdata/testdir')
    format = Format.new(file_stats, reverse: true)
    actual = format.render

    expected = <<~TEXT.chomp
      foo.txt  bar.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_listing_format
    file_stats = generate_file_stats_classes('./08.ls_object/testdata/testdir')
    format = Format.new(file_stats, all: true, long: true)
    actual = format.render

    expected = <<~TEXT.chomp
      total 8
      drwxr-xr-x 2 misono misono 4096 Sep 25 12:02 .
      drwxr-xr-x 3 misono misono 4096 Sep 25 12:02 ..
      -rw-r--r-- 1 misono misono    0 Sep 25 12:02 bar.txt
      -rw-r--r-- 1 misono misono    0 Sep 25 12:02 foo.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_reverse_format
    file_stats = generate_file_stats_classes('./08.ls_object/testdata')
    format = Format.new(file_stats, all: true, long: true, reverse: true)
    actual = format.render

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 2 misono misono 4096 Sep 25 12:02 testdir
      -rw-r--r-- 1 misono misono    0 Sep 25 12:02 .hoge
      -rw-r--r-- 1 misono misono  446 Sep 25 12:02 foo.md
      -rw-r--r-- 1 misono misono    0 Sep 25 12:02 bar.txt
      drwxr-xr-x 5 misono misono 4096 Sep 25 12:59 ..
      drwxr-xr-x 3 misono misono 4096 Sep 25 12:02 .
    TEXT
    assert_equal expected, actual
  end
end
