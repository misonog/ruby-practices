#!/usr/bin/env ruby
# frozen_string_literal: true

# ボウリング計算プログラムの実行
def main
  score = ARGV[0]
  scores = parse_score(score)
  frames = convert_to_frames(scores)
  puts calc_total_score(frames)
end

def parse_score(score)
  score.split(',').map { |s| s == 'X' ? 10 : s.to_i }
end

# スコアをフレーム毎のリストに変換する
def convert_to_frames(scores)
  frame = []
  frames = []
  scores.each do |score|
    frame << score

    next unless frames.size < 9 && (score == 10 || frame.size >= 2)

    frames << frame
    frame = []
  end

  frames << frame
end

def calc_total_score(frames)
  last_frame_idx = frames.size - 1
  frames.each_with_index.sum do |frame, idx|
    if strike?(frame) && idx != last_frame_idx
      calc_strike_score(frames, idx)
    elsif spare?(frame) && idx != last_frame_idx
      calc_spare_score(frames, idx)
    else
      frame.sum
    end
  end
end

def strike?(frame)
  frame[0] == 10
end

def calc_strike_score(frames, idx)
  next_idx = idx + 1
  last_frame_idx = frames.size - 1
  if strike?(frames[next_idx]) && next_idx != last_frame_idx
    frames[idx][0] + frames[next_idx][0] + frames[idx + 2][0]
  else
    frames[idx][0] + frames[next_idx][0, 2].sum
  end
end

def spare?(frame)
  !strike?(frame) && frame.sum == 10
end

def calc_spare_score(frames, idx)
  frames[idx].sum + frames[idx + 1][0]
end

main if $PROGRAM_NAME == __FILE__
