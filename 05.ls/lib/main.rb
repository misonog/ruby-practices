#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'ls'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:all] = v }
  opt.on('-l') { |v| params[:long] = v }
  opt.on('-r') { |v| params[:reverse] = v }
  opt.parse!(ARGV)

  file_stats = LS.generate_file_stats_class(ARGV.empty? ? '.' : ARGV[0])
  formatter = LS::Formatter.new(file_stats, **params)
  puts formatter.render
end

main if $PROGRAM_NAME == __FILE__
