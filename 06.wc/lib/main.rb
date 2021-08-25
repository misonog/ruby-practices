#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'wc'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:lines] = v }
  opt.parse!(ARGV)

  # 標準入力にも引数にもデータがなかった場合、無限に入力を待ち続けてしまう
  word_counts = if ARGV.empty?
                  contents = reallines
                  [WC.create_word_count(contents)]
                else
                  WC.create_word_count_from_path(ARGV)
                end

  format = WC::Format.new(word_counts, **params)
  puts format.render
end

main if $PROGRAM_NAME == __FILE__
