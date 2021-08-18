# frozen_string_literal: true

module WC
  def self.read_files(paths)
    paths.map { |path| File.readlines(path) }
  end

  class WordCount
    attr_reader :lines, :words, :bytes, :name

    def initialize(contents, path = '')
      @lines = contents.size
      @words = contents.join.split(/\s+/).count { |s| !s.empty? }
      @bytes = contents.join.bytesize
      @name = path
    end
  end
end
