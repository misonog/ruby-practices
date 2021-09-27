# frozen_string_literal: true

require_relative 'file_stat'
require_relative 'long_renderer'
require_relative 'short_renderer'

class Command
  def initialize(path, all: false, reverse: false, long: false)
    @file_stats = generate_file_stats_classes(path, all, reverse)
    @renderer = long ? LongRenderer.new(@file_stats) : ShortRenderer.new(@file_stats)
  end

  def run
    @renderer.render
  end

  private

  def generate_file_stats_classes(path, all, reverse)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    file_stats = paths.map { |p| FileStat.new(p) }
    file_stats.sort_by! { |f| ignore_dot_in_dotfile(f.name, f.dotfile) }
    file_stats.reverse! if reverse
    file_stats.reject! { |f| /^[.]+/.match?(f.name) } unless all

    file_stats
  end

  def ignore_dot_in_dotfile(name, dotfile)
    dotfile ? name.delete_prefix('.') : name
  end
end
