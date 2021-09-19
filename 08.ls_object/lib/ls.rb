# frozen_string_literal: true

require_relative 'ls/file_stat'

module LS
  def self.generate_file_stats_class(path)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    paths.map { |p| LS::FileStat.new(p) }
  end
end
