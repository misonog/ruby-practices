#!/usr/bin/env ruby
# frozen_string_literal: true

# score = ARGV[0]

def parse_score(score)
  score.split(',').map { |s| s == 'X' ? 10 : s.to_i }
end

# スコアをフレーム毎のリストに変換する
def convert_to_frames(scores)
  pin = 10
  frame = []
  frames = []
  scores.each do |score|
    pin -= score
    frame << score

    next unless frames.size < 9 && (pin.zero? || frame.size >= 2)

    frames << frame
    pin = 10
    frame = []
  end

  frames << frame
end
