#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require './05.ls/lib/ls'

def main
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:all] = v }
  opt.on('-l') { |v| params[:long] = v }
  opt.on('-r') { |v| params[:reverse] = v }
  opt.parse!(ARGV)
end

main if $PROGRAM_NAME == __FILE__
