# frozen_string_literal: true

require_relative 'ls/file_stat'
require_relative 'ls/format'

module LS
  def self.run(path, params)
    file_stats = generate_file_stats_class(path)
    format = LS::Format.new(file_stats, **params)
    puts format.render
  end

  def self.generate_file_stats_class(path)
    paths = Dir.foreach(path).map { |entry| File.join(path, entry) }
    paths.map { |p| LS::FileStat.new(p) }
  end
end
