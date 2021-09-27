#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/command'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:all] = v }
  opt.on('-l') { |v| params[:long] = v }
  opt.on('-r') { |v| params[:reverse] = v }
  opt.parse!(ARGV)

  path = ARGV.empty? ? '.' : ARGV[0]
  ls = Command.new(path, **params)
  puts ls.run
end

main if $PROGRAM_NAME == __FILE__
