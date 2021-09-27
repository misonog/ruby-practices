# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/file_stat'
require_relative '../lib/command'

class CommandTest < Minitest::Test
  def generate_file_stats_classes(path)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    paths.map { |p| FileStat.new(p) }
  end

  def test_default_format
    ls = Command.new('./08.ls_object/testdata')
    actual = ls.run

    expected = <<~TEXT.chomp
      bar.txt  foo.md  testdir
    TEXT
    assert_equal expected, actual
  end

  def test_all_file_format
    ls = Command.new('./08.ls_object/testdata', all: true)
    actual = ls.run

    expected = <<~TEXT.chomp
      .   bar.txt  .hoge#{'  '}
      ..  foo.md   testdir
    TEXT
    assert_equal expected, actual
  end

  def test_reverse_format
    ls = Command.new('./08.ls_object/testdata/testdir', reverse: true)
    actual = ls.run

    expected = <<~TEXT.chomp
      foo.txt  bar.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_listing_format
    ls = Command.new('./08.ls_object/testdata/testdir', all: true, long: true)
    actual = ls.run

    expected = <<~TEXT.chomp
      total 8
      drwxr-xr-x 2 misono misono 4096 Sep 27 22:52 .
      drwxr-xr-x 3 misono misono 4096 Sep 27 22:52 ..
      -rw-r--r-- 1 misono misono    0 Sep 27 22:52 bar.txt
      -rw-r--r-- 1 misono misono    0 Sep 27 22:52 foo.txt
    TEXT
    assert_equal expected, actual
  end

  def test_all_long_reverse_format
    ls = Command.new('./08.ls_object/testdata', all: true, long: true, reverse: true)
    actual = ls.run

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 2 misono misono 4096 Sep 27 22:52 testdir
      -rw-r--r-- 1 misono misono    0 Sep 27 22:52 .hoge
      -rw-r--r-- 1 misono misono  446 Sep 27 22:52 foo.md
      -rw-r--r-- 1 misono misono    0 Sep 27 22:52 bar.txt
      drwxr-xr-x 5 misono misono 4096 Sep 27 23:03 ..
      drwxr-xr-x 3 misono misono 4096 Sep 27 22:52 .
    TEXT
    assert_equal expected, actual
  end
end
