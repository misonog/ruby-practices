# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  MAX_FRAMES_SIZE = 10

  def initialize(all_marks)
    @frames = convert_to_frames(all_marks)
  end

  def score
    @frames.sum do |frame|
      if frame.strike? && !frame.last?
        calc_strike_score(frame)
      elsif frame.spare? && !frame.last?
        calc_spare_score(frame)
      else
        frame.num_of_knocked_down_pins
      end
    end
  end

  private

  def convert_to_frames(all_marks)
    current_frame = []
    frames = []
    all_marks.split(',').each do |mark|
      current_frame << mark

      next unless frames.size < Frame::MAX_FRAME_INDEX && (mark == Shot::STRIKE_MARK || current_frame.size >= 2)

      frames << Frame.new(current_frame, frames.size)
      current_frame = []
    end

    frames << Frame.new(current_frame, frames.size)
  end

  def calc_strike_score(current_frame)
    next_idx = current_frame.index + 1
    next_frame = @frames[next_idx]
    if next_frame.strike? && !next_frame.last?
      current_frame.num_of_knocked_down_pins + next_frame.num_of_knocked_down_pins + @frames[next_idx + 1].calc_score_until_num_of_shot(1)
    else
      current_frame.num_of_knocked_down_pins + next_frame.calc_score_until_num_of_shot(2)
    end
  end

  def calc_spare_score(current_frame)
    current_frame.num_of_knocked_down_pins + @frames[current_frame.index + 1].calc_score_until_num_of_shot(1)
  end
end
