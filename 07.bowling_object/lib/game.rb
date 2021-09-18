# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  STRIKE_MARK = 'X'
  MAX_FRAMES_SIZE = 10

  def initialize(marks)
    @frames = convert_to_frames(marks)
  end

  def score
    last_frame_idx = @frames.size - 1
    @frames.each_with_index.sum do |f, idx|
      frame = Frame.new(f)
      if frame.strike? && idx != last_frame_idx
        calc_strike_score(idx)
      elsif frame.spare? && idx != last_frame_idx
        calc_spare_score(idx)
      else
        frame.score
      end
    end
  end

  private

  def convert_to_frames(marks)
    frame = []
    frames = []
    marks.split(',').each do |mark|
      frame << mark

      next unless frames.size < MAX_FRAMES_SIZE - 1 && (mark == STRIKE_MARK || frame.size >= 2)

      frames << frame
      frame = []
    end

    frames << frame
  end

  def calc_strike_score(idx)
    next_idx = idx + 1
    last_frame_idx = @frames.size - 1
    current_frame = Frame.new(@frames[idx])
    # 10フレーム目に3投している場合への対応
    next_frame = Frame.new(@frames[next_idx][0, 2])
    if next_frame.strike? && next_idx != last_frame_idx
      current_frame.score + next_frame.score + Shot.new(@frames[idx + 2][0]).score
    else
      current_frame.score + next_frame.score
    end
  end

  def calc_spare_score(idx)
    Frame.new(@frames[idx]).score + Shot.new(@frames[idx + 1][0]).score
  end
end
