#!/usr/bin/env ruby
# frozen_string_literal: true

# score = ARGV[0]

def parse_score(score)
  score.split(',').map { |s| s == 'X' ? 10 : s.to_i }
end
