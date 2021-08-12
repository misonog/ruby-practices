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

def strike?(frame)
  frame[0] == 10
end

def calc_strike_score(frames, idx)
  next_idx = idx + 1
  if strike?(frames[next_idx]) && next_idx != 9
    frames[idx][0] + frames[next_idx][0] + frames[idx + 2][0]
  else
    frames[idx][0] + frames[next_idx][0, 2].sum
  end
end

def calc_spare_score(frames, idx)
  frames[idx].sum + frames[idx + 1][0]
end
