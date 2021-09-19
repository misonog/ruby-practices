#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'lib/ls'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:all] = v }
  opt.on('-l') { |v| params[:long] = v }
  opt.on('-r') { |v| params[:reverse] = v }
  opt.parse!(ARGV)

  path = ARGV.empty? ? '.' : ARGV[0]
  LS.run(path, params)
end

main if $PROGRAM_NAME == __FILE__
