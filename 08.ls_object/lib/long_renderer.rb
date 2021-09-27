# frozen_string_literal: true

require 'date'

class LongRenderer
  def initialize(file_stats)
    @file_stats = file_stats
  end

  def render
    # total blocks は半分にすると一致するため、2 で割る
    total_blocks = @file_stats.inject(0) { |result, f| result + f.blocks } / 2
    max_size_length = calc_max_size_length

    result = ["total #{total_blocks}"]
    @file_stats.each do |f|
      result << "#{f.permission} #{f.hardlink} #{f.owner} #{f.group} #{f.size.to_s.rjust(max_size_length)} #{f.timestamp.strftime('%b %d %H:%M')} #{f.name}"
    end
    result.join("\n")
  end

  private

  def calc_max_size_length
    sizes = []
    @file_stats.each { |f| sizes << f.size }
    sizes.max.to_s.length
  end
end
