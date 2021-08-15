# frozen_string_literal: true

require 'minitest/autorun'
require './05.ls/lib/ls'

class LSTest < Minitest::Test
  def test_generate_path_list
    expected = %w[./05.ls/testdata/testdir ./05.ls/testdata/bar.txt ./05.ls/testdata/.hoge ./05.ls/testdata/foo.md ./05.ls/testdata/.. ./05.ls/testdata/.]
    actual = LS.generate_path_list('./05.ls/testdata')
    assert_equal expected, actual
  end

  def test_all_long_listing_format
    file_stats = LS.convert_path_to_class(LS.generate_path_list('./05.ls/testdata'))
    formatter = LS::Formatter.new(file_stats, all: true, long: true)

    expected = <<~TEXT.chomp
      total 16
      drwxr-xr-x 3 misono misono 4096 Aug 15 16:59 .
      drwxr-xr-x 5 misono misono 4096 Aug 14 19:40 ..
      -rwxr--r-- 1 misono misono    0 Aug 15 16:59 bar.txt
      -rw-r--r-- 1 misono misono  446 Aug 14 19:46 foo.md
      -rw-r--r-- 1 misono misono    0 Aug 14 19:41 .hoge
      drwxr-xr-x 2 misono misono 4096 Aug 15 16:59 testdir
    TEXT
    actual = formatter.render
    assert_equal expected, actual
  end
end
