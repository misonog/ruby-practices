# frozen_string_literal: true

module WC
  def self.create_word_count_from_path(paths)
    paths.map { |path| create_word_count(File.readlines(path), path) }
  end

  def self.create_word_count(contents, path = '')
    WordCount.new(contents, path)
  end

  class WordCount
    attr_reader :lines, :words, :bytes, :name

    def initialize(contents, path)
      @lines = contents.size
      @words = contents.join.split(/\s+/).count { |s| !s.empty? }
      @bytes = contents.join.bytesize
      @name = path
    end
  end
end
