# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  MAX_FRAMES_SIZE = 10

  def initialize(all_marks)
    @frames = convert_to_frames(all_marks)
  end

  def score
    last_frame_idx = @frames.size - 1
    @frames.each_with_index.sum do |frame, idx|
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

  def convert_to_frames(all_marks)
    current_frame = []
    frames = []
    all_marks.split(',').each do |mark|
      current_frame << mark

      next unless frames.size < MAX_FRAMES_SIZE - 1 && (mark == Shot::STRIKE_MARK || current_frame.size >= 2)

      frames << Frame.new(current_frame)
      current_frame = []
    end

    frames << Frame.new(current_frame)
  end

  def calc_strike_score(idx)
    next_idx = idx + 1
    last_frame_idx = @frames.size - 1
    current_frame = @frames[idx]
    next_frame = @frames[next_idx]
    if next_frame.strike? && next_idx != last_frame_idx
      current_frame.score + next_frame.score + @frames[idx + 2].calc_score_until_num_of_shot(1)
    else
      current_frame.score + next_frame.calc_score_until_num_of_shot(2)
    end
  end

  def calc_spare_score(idx)
    @frames[idx].score + @frames[idx + 1].calc_score_until_num_of_shot(1)
  end
end
