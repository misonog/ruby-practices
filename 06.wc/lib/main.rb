#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require './06.wc/lib/wc'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:lines] = v }
  opt.parse!(ARGV)

  # 標準入力にも引数にもデータがなかった場合、無限に入力を待ち続けてしまう
  if ARGV.empty?
    contents = readlines
    word_counts = [WC.create_word_count(contents)]
  else
    word_counts = WC.create_word_count_from_path(ARGV)
  end

  format = WC::Format.new(word_counts, **params)
  puts format.render
end

main if $PROGRAM_NAME == __FILE__
