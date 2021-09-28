#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/game'

def main
  marks = ARGV[0]
  game = Game.new(marks)
  puts game.score
end

main if $PROGRAM_NAME == __FILE__
