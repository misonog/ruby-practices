# frozen_string_literal: true

require_relative 'file_stat'
require_relative 'format'

class Command
  def initialize(path, params)
    @file_stats = generate_file_stats_classes(path)
    @params = params
  end

  def run
    format = Format.new(@file_stats, **@params)
    format.render
  end

  private

  def generate_file_stats_classes(path)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    paths.map { |p| FileStat.new(p) }
  end
end
